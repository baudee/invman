// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:postgres/postgres.dart';
import 'package:yaml/yaml.dart';

const validEnvironments = ['development', 'staging', 'production'];

Future<void> main(List<String> args) async {
  final env = _parseEnvironment(args);
  print('Populating database for environment: $env');

  final passwords = _loadPasswords(env);

  final connection = await _connectToDatabase(passwords);

  try {
    await _populateAppSettings(connection);
    await _populateCurrencies(connection);
    await _populateStocks(connection);
    print('Database population completed successfully.');
  } finally {
    await connection.close();
  }
}

Future<void> _populateAppSettings(Connection connection) async {
  await connection.execute('''
    INSERT INTO app_settings ("maintenanceMode", "minVersion", "appStoreUrl", "playStoreUrl", "symbolsUpdatedAt")
    VALUES (false, '1.0.0', NULL, NULL, '2026-03-18T00:00:00Z')
  ''');
}

String _parseEnvironment(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart scripts/populate/populate.dart <environment>');
    print('Valid environments: ${validEnvironments.join(', ')}');
    exit(1);
  }

  final env = args[0];
  if (!validEnvironments.contains(env)) {
    print('Invalid environment: $env');
    print('Valid environments: ${validEnvironments.join(', ')}');
    exit(1);
  }

  return env;
}

Map<String, dynamic> _loadPasswords(String env) {
  final passwordsFile = File('config/passwords.yaml');
  if (!passwordsFile.existsSync()) {
    print('Passwords file not found: config/passwords.yaml');
    exit(1);
  }

  final yaml = loadYaml(passwordsFile.readAsStringSync()) as YamlMap;
  final passwords = _yamlMapToMap(yaml);

  final envPasswords = passwords[env] as Map<String, dynamic>?;
  if (envPasswords == null) {
    print('No passwords found for environment: $env');
    exit(1);
  }

  return envPasswords;
}

Map<String, dynamic> _yamlMapToMap(YamlMap yaml) {
  return yaml.map((key, value) {
    if (value is YamlMap) {
      return MapEntry(key.toString(), _yamlMapToMap(value));
    }
    return MapEntry(key.toString(), value);
  });
}

Future<Connection> _connectToDatabase(
  Map<String, dynamic> passwords,
) async {
  final host = "localhost";
  final port = 8090;
  final name = "invman";
  final user = "postgres";
  final password = passwords['database'] as String;

  print('Connecting to database $name at $host:$port...');

  final connection = await Connection.open(
    Endpoint(
      host: host,
      port: port,
      database: name,
      username: user,
      password: password,
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  print('Connected to database.');
  return connection;
}

Future<void> _populateCurrencies(Connection connection) async {
  print('Populating currencies...');

  final csvFile = File('scripts/populate/data/currencies.csv');
  if (!csvFile.existsSync()) {
    print('Warning: currencies.csv not found, skipping currencies.');
    return;
  }

  final csvContent = csvFile.readAsStringSync();
  final rows = const CsvToListConverter(eol: '\n').convert(csvContent);

  if (rows.isEmpty) {
    print('Warning: currencies.csv is empty.');
    return;
  }

  final headers = rows.first.map((e) => e.toString().trim()).toList();
  final codeIndex = headers.indexOf('code');

  if (codeIndex == -1) {
    print('Error: currencies.csv must have a "code" column.');
    return;
  }

  // Load all existing currency codes at once
  final existingResult = await connection.execute('SELECT code FROM currency');
  final existingCodes = existingResult.map((r) => r[0] as String).toSet();

  // Filter to only new currencies
  final newCurrencies = <String>[];
  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final code = row[codeIndex].toString().trim();
    if (code.isEmpty) continue;
    if (!existingCodes.contains(code)) {
      newCurrencies.add(code);
    }
  }

  final skippedCount = rows.length - 1 - newCurrencies.length;

  if (newCurrencies.isEmpty) {
    print('  Currencies: inserted 0, skipped $skippedCount (already exist).');
    return;
  }

  // Batch insert using unnest
  await connection.execute(
    Sql.named('''
      INSERT INTO currency (code, "dollarValue", "timestamp", "updatedAt")
      SELECT code, 1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'
      FROM unnest(@codes::text[]) AS code
    '''),
    parameters: {'codes': newCurrencies},
  );

  print('  Currencies: inserted ${newCurrencies.length}, skipped $skippedCount (already exist).');
}

Future<void> _populateStocks(Connection connection) async {
  final currencyMap = await _loadCurrencyMap(connection);

  await _populateCryptos(connection, currencyMap);
  await _populateEtfs(connection, currencyMap);
  await _populateEquities(connection, currencyMap);
  await _populateIndices(connection, currencyMap);
  await _populateCommodities(connection, currencyMap);
}

Future<Map<String, int>> _loadCurrencyMap(Connection connection) async {
  final result = await connection.execute(Sql.named('SELECT id, code FROM currency'));

  final map = <String, int>{};
  for (final row in result) {
    map[row[1] as String] = row[0] as int;
  }

  return map;
}

Future<void> _populateCryptos(
  Connection connection,
  Map<String, int> currencyMap,
) async {
  const filePath = 'scripts/populate/data/cryptos.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    print('Warning: cryptos.json not found, skipping.');
    return;
  }

  print('Populating cryptos from cryptos.json...');

  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);

  if (items.isEmpty) {
    print('  Warning: cryptos.json is empty.');
    return;
  }

  final existingResult = await connection.execute('SELECT symbol FROM stock');
  final existingSymbols = existingResult.map((r) => r[0] as String).toSet();

  final usdCurrencyId = currencyMap['USD'];
  if (usdCurrencyId == null) {
    print('  Error: USD currency not found in database.');
    return;
  }

  final symbols = <String>[];
  final names = <String>[];
  final currencyIds = <int>[];
  final logoUrls = <String>[];

  var skippedCount = 0;

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    if (existingSymbols.contains(symbol)) {
      skippedCount++;
      continue;
    }

    final name = (item['name'] as String?)?.trim() ?? symbol;

    symbols.add(symbol);
    names.add(name);
    currencyIds.add(usdCurrencyId);
    logoUrls.add("https://raw.githubusercontent.com/nvstly/icons/refs/heads/main/ticker_icons/$symbol.png");
  }

  if (symbols.isEmpty) {
    print('  cryptos.json: inserted 0, skipped $skippedCount.');
    return;
  }

  await connection.execute(
    Sql.named('''
      INSERT INTO stock (id, symbol, "name", "quoteType", "logoUrl", "price", "timestamp", "updatedAt", "currencyId")
      SELECT gen_random_uuid(), symbol, name, @quoteType, logo_url, -1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', currency_id
      FROM unnest(@symbols::text[], @names::text[], @logoUrls::text[], @currencyIds::int[]) AS t(symbol, name, logo_url, currency_id)
      ON CONFLICT (symbol) DO NOTHING
    '''),
    parameters: {
      'symbols': symbols,
      'names': names,
      'quoteType': StockType.crypto.name,
      'logoUrls': logoUrls,
      'currencyIds': currencyIds,
    },
  );

  print('  cryptos.json: inserted ${symbols.length}, skipped $skippedCount.');
}

Future<void> _populateEquities(
  Connection connection,
  Map<String, int> currencyMap,
) async {
  const filePath = 'scripts/populate/data/equities.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    print('Warning: equities.json not found, skipping.');
    return;
  }

  print('Populating equities from equities.json...');

  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);

  if (items.isEmpty) {
    print('  Warning: equities.json is empty.');
    return;
  }

  final existingResult = await connection.execute('SELECT symbol FROM stock');
  final existingSymbols = existingResult.map((r) => r[0] as String).toSet();

  final symbols = <String>[];
  final names = <String>[];
  final currencyIds = <int>[];
  final logoUrls = <String>[];

  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    if (existingSymbols.contains(symbol)) {
      skippedCount++;
      continue;
    }

    final name = (item['companyName'] as String?)?.trim() ?? symbol;
    final currencyCode = (item['tradingCurrency'] as String?)?.trim().toUpperCase() ?? '';

    if (currencyCode.isEmpty) {
      print('Skipping equity with missing currency: $symbol');
      print(item);
      missingCurrencyCount++;
      continue;
    }

    final currencyId = currencyMap[currencyCode];
    if (currencyId == null) {
      print('Skipping equity with unknown currency "$currencyCode": $symbol');
      print(item);
      missingCurrencyCount++;
      continue;
    }

    symbols.add(symbol);
    names.add(name);
    currencyIds.add(currencyId);
    logoUrls.add("https://raw.githubusercontent.com/nvstly/icons/refs/heads/main/ticker_icons/$symbol.png");
  }

  if (symbols.isEmpty) {
    print('  equities.json: inserted 0, skipped $skippedCount, missing currency $missingCurrencyCount.');
    return;
  }

  await connection.execute(
    Sql.named('''
      INSERT INTO stock (id, symbol, "name", "quoteType", "logoUrl", "price", "timestamp", "updatedAt", "currencyId")
      SELECT gen_random_uuid(), symbol, name, @quoteType, logo_url, -1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', currency_id
      FROM unnest(@symbols::text[], @names::text[], @logoUrls::text[], @currencyIds::int[]) AS t(symbol, name, logo_url, currency_id)
      ON CONFLICT (symbol) DO NOTHING
    '''),
    parameters: {
      'symbols': symbols,
      'names': names,
      'quoteType': StockType.equity.name,
      'logoUrls': logoUrls,
      'currencyIds': currencyIds,
    },
  );

  print('  equities.json: inserted ${symbols.length}, skipped $skippedCount, missing currency $missingCurrencyCount.');
}

Future<void> _populateIndices(
  Connection connection,
  Map<String, int> currencyMap,
) async {
  const filePath = 'scripts/populate/data/indices.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    print('Warning: indices.json not found, skipping.');
    return;
  }

  print('Populating indices from indices.json...');

  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);

  if (items.isEmpty) {
    print('  Warning: indices.json is empty.');
    return;
  }

  final existingResult = await connection.execute('SELECT symbol FROM stock');
  final existingSymbols = existingResult.map((r) => r[0] as String).toSet();

  final symbols = <String>[];
  final names = <String>[];
  final currencyIds = <int>[];
  final logoUrls = <String>[];

  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    if (existingSymbols.contains(symbol)) {
      skippedCount++;
      continue;
    }

    final name = (item['name'] as String?)?.trim() ?? symbol;
    final currencyCode = (item['currency'] as String?)?.trim().toUpperCase() ?? '';

    if (currencyCode.isEmpty) {
      missingCurrencyCount++;
      continue;
    }

    final currencyId = currencyMap[currencyCode];
    if (currencyId == null) {
      missingCurrencyCount++;
      continue;
    }

    symbols.add(symbol);
    names.add(name);
    currencyIds.add(currencyId);
    logoUrls.add("https://raw.githubusercontent.com/nvstly/icons/refs/heads/main/ticker_icons/$symbol.png");
  }

  if (symbols.isEmpty) {
    print('  indices.json: inserted 0, skipped $skippedCount, missing currency $missingCurrencyCount.');
    return;
  }

  await connection.execute(
    Sql.named('''
      INSERT INTO stock (id, symbol, "name", "quoteType", "logoUrl", "price", "timestamp", "updatedAt", "currencyId")
      SELECT gen_random_uuid(), symbol, name, @quoteType, logo_url, -1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', currency_id
      FROM unnest(@symbols::text[], @names::text[], @logoUrls::text[], @currencyIds::int[]) AS t(symbol, name, logo_url, currency_id)
      ON CONFLICT (symbol) DO NOTHING
    '''),
    parameters: {
      'symbols': symbols,
      'names': names,
      'quoteType': StockType.indice.name,
      'logoUrls': logoUrls,
      'currencyIds': currencyIds,
    },
  );

  print('  indices.json: inserted ${symbols.length}, skipped $skippedCount, missing currency $missingCurrencyCount.');
}

Future<void> _populateEtfs(
  Connection connection,
  Map<String, int> currencyMap,
) async {
  const filePath = 'scripts/populate/data/etfs_with_currency.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    print('Warning: etfs_with_currency.json not found, skipping.');
    print('  Run scrape_etf_currencies.dart first to generate this file.');
    return;
  }

  print('Populating ETFs from etfs_with_currency.json...');

  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);

  if (items.isEmpty) {
    print('  Warning: etfs_with_currency.json is empty.');
    return;
  }

  final existingResult = await connection.execute('SELECT symbol FROM stock');
  final existingSymbols = existingResult.map((r) => r[0] as String).toSet();

  final symbols = <String>[];
  final names = <String>[];
  final currencyIds = <int>[];
  final logoUrls = <String>[];

  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    if (existingSymbols.contains(symbol)) {
      skippedCount++;
      continue;
    }

    final name = (item['name'] as String?)?.trim() ?? symbol;
    final currencyCode = (item['currency'] as String?)?.trim().toUpperCase() ?? '';

    if (currencyCode.isEmpty) {
      print('Skipping ETF with missing currency: $symbol');
      print(item);
      missingCurrencyCount++;
      continue;
    }

    final currencyId = currencyMap[currencyCode];
    if (currencyId == null) {
      print('Skipping ETF with unknown currency "$currencyCode": $symbol');
      print(item);
      missingCurrencyCount++;
      continue;
    }

    symbols.add(symbol);
    names.add(name);
    currencyIds.add(currencyId);
    logoUrls.add("https://raw.githubusercontent.com/nvstly/icons/refs/heads/main/ticker_icons/$symbol.png");
  }

  if (symbols.isEmpty) {
    print('  etfs_with_currency.json: inserted 0, skipped $skippedCount, missing currency $missingCurrencyCount.');
    return;
  }

  await connection.execute(
    Sql.named('''
      INSERT INTO stock (id, symbol, "name", "quoteType", "logoUrl", "price", "timestamp", "updatedAt", "currencyId")
      SELECT gen_random_uuid(), symbol, name, @quoteType, logo_url, -1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', currency_id
      FROM unnest(@symbols::text[], @names::text[], @logoUrls::text[], @currencyIds::int[]) AS t(symbol, name, logo_url, currency_id)
      ON CONFLICT (symbol) DO NOTHING
    '''),
    parameters: {
      'symbols': symbols,
      'names': names,
      'quoteType': StockType.etf.name,
      'logoUrls': logoUrls,
      'currencyIds': currencyIds,
    },
  );

  print(
    '  etfs_with_currency.json: inserted ${symbols.length}, skipped $skippedCount, missing currency $missingCurrencyCount.',
  );
}

Future<void> _populateCommodities(
  Connection connection,
  Map<String, int> currencyMap,
) async {
  const filePath = 'scripts/populate/data/commodities.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    print('Warning: commodities.json not found, skipping.');
    return;
  }

  print('Populating commodities from commodities.json...');

  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);

  if (items.isEmpty) {
    print('  Warning: commodities.json is empty.');
    return;
  }

  final existingResult = await connection.execute('SELECT symbol FROM stock');
  final existingSymbols = existingResult.map((r) => r[0] as String).toSet();

  final symbols = <String>[];
  final names = <String>[];
  final currencyIds = <int>[];
  final logoUrls = <String>[];

  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    if (existingSymbols.contains(symbol)) {
      skippedCount++;
      continue;
    }

    final name = (item['name'] as String?)?.trim() ?? symbol;
    final currencyCode = (item['currency'] as String?)?.trim().toUpperCase() ?? '';

    if (currencyCode.isEmpty) {
      missingCurrencyCount++;
      continue;
    }

    final currencyId = currencyMap[currencyCode];
    if (currencyId == null) {
      missingCurrencyCount++;
      continue;
    }

    symbols.add(symbol);
    names.add(name);
    currencyIds.add(currencyId);
    logoUrls.add("https://raw.githubusercontent.com/nvstly/icons/refs/heads/main/ticker_icons/$symbol.png");
  }

  if (symbols.isEmpty) {
    print('  commodities.json: inserted 0, skipped $skippedCount, missing currency $missingCurrencyCount.');
    return;
  }

  await connection.execute(
    Sql.named('''
      INSERT INTO stock (id, symbol, "name", "quoteType", "logoUrl", "price", "timestamp", "updatedAt", "currencyId")
      SELECT gen_random_uuid(), symbol, name, @quoteType, logo_url, -1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', currency_id
      FROM unnest(@symbols::text[], @names::text[], @logoUrls::text[], @currencyIds::int[]) AS t(symbol, name, logo_url, currency_id)
      ON CONFLICT (symbol) DO NOTHING
    '''),
    parameters: {
      'symbols': symbols,
      'names': names,
      'quoteType': StockType.commodity.name,
      'logoUrls': logoUrls,
      'currencyIds': currencyIds,
    },
  );

  print('  commodities.json: inserted ${symbols.length}, skipped $skippedCount, missing currency $missingCurrencyCount.');
}

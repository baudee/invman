// ignore_for_file: avoid_print

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
    INSERT INTO app_settings ("maintenanceMode", "minVersion", "appStoreUrl", "playStoreUrl")
    VALUES (false, '1.0.0', NULL, NULL)
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
  final port = 5432;
  final name = "serverpod";
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

  await _populateStockFile(
    connection,
    'scripts/populate/data/cryptos.csv',
    StockType.crypto,
    currencyMap,
  );
  await _populateStockFile(
    connection,
    'scripts/populate/data/equities.csv',
    StockType.equity,
    currencyMap,
  );
  await _populateStockFile(
    connection,
    'scripts/populate/data/etfs.csv',
    StockType.etf,
    currencyMap,
  );
  await _populateStockFile(
    connection,
    'scripts/populate/data/funds.csv',
    StockType.fund,
    currencyMap,
  );
  await _populateStockFile(
    connection,
    'scripts/populate/data/indices.csv',
    StockType.indice,
    currencyMap,
  );
}

Future<Map<String, int>> _loadCurrencyMap(Connection connection) async {
  final result = await connection.execute(Sql.named('SELECT id, code FROM currency'));

  final map = <String, int>{};
  for (final row in result) {
    map[row[1] as String] = row[0] as int;
  }

  return map;
}

Future<void> _populateStockFile(
  Connection connection,
  String filePath,
  StockType stockType,
  Map<String, int> currencyMap,
) async {
  final csvFile = File(filePath);
  final fileName = filePath.split('/').last;

  if (!csvFile.existsSync()) {
    print('Warning: $fileName not found, skipping.');
    return;
  }

  print('Populating stocks from $fileName...');

  final csvContent = csvFile.readAsStringSync();
  final rows = const CsvToListConverter(eol: '\n').convert(csvContent);

  if (rows.isEmpty) {
    print('  Warning: $fileName is empty.');
    return;
  }

  final headers = rows.first.map((e) => e.toString().trim().toLowerCase()).toList();

  final symbolIndex = headers.indexOf('symbol');
  final nameIndex = headers.indexOf('name');
  final currencyIndex = headers.indexOf('currency');

  if (symbolIndex == -1) {
    print('  Error: $fileName must have a "symbol" column.');
    return;
  }

  // Load all existing stock symbols at once
  final existingResult = await connection.execute('SELECT symbol FROM stock');
  final existingSymbols = existingResult.map((r) => r[0] as String).toSet();

  // Collect stocks to insert
  final symbols = <String>[];
  final names = <String>[];
  final currencyIds = <int>[];
  final logoUrls = <String>[];

  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final symbol = row[symbolIndex].toString().trim();
    if (symbol.isEmpty) continue;

    if (existingSymbols.contains(symbol)) {
      skippedCount++;
      continue;
    }

    final name = nameIndex != -1 ? row[nameIndex].toString().trim() : symbol;

    if (currencyIndex == -1) {
      missingCurrencyCount++;
      continue;
    }

    final currencyCode = row[currencyIndex].toString().trim();
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
    print(
      '  $fileName: inserted 0, skipped $skippedCount, '
      'missing currency $missingCurrencyCount.',
    );
    return;
  }

  // Batch insert using unnest, skip duplicates
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
      'quoteType': stockType.name,
      'logoUrls': logoUrls,
      'currencyIds': currencyIds,
    },
  );

  print(
    '  $fileName: inserted ${symbols.length}, skipped $skippedCount, '
    'missing currency $missingCurrencyCount.',
  );
}

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
    await connection.runTx((tx) async {
      await _populateAppSettings(tx);
      await _populateCurrencies(tx);
      await _populateAssets(tx);
    });
    print('Database population completed successfully.');
  } catch (e) {
    print('Error during population, all changes rolled back: $e');
    exit(1);
  } finally {
    await connection.close();
  }
}

Future<void> _populateAppSettings(TxSession connection) async {
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

Future<void> _populateCurrencies(TxSession connection) async {
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
      INSERT INTO currency (code)
      SELECT code
      FROM unnest(@codes::text[]) AS code
    '''),
    parameters: {'codes': newCurrencies},
  );

  print('  Currencies: inserted ${newCurrencies.length}, skipped $skippedCount (already exist).');
}

Future<void> _populateAssets(TxSession connection) async {
  final currencyMap = await _loadCurrencyMap(connection);

  await _populateAssetFile(connection, currencyMap, 'stocks', AssetType.stock);
  await _populateAssetFile(connection, currencyMap, 'etfs', AssetType.etf);
  await _populateAssetFile(connection, currencyMap, 'cryptos', AssetType.crypto);
  await _populateAssetFile(connection, currencyMap, 'commodities', AssetType.commodity);
}

Future<Map<String, int>> _loadCurrencyMap(TxSession connection) async {
  final result = await connection.execute(Sql.named('SELECT id, code FROM currency'));

  final map = <String, int>{};
  for (final row in result) {
    map[row[1] as String] = row[0] as int;
  }

  return map;
}

String _makeKey(String symbol, String? exchange) {
  return '$symbol:${exchange ?? ''}';
}

Future<void> _populateAssetFile(
  TxSession connection,
  Map<String, int> currencyMap,
  String fileName,
  AssetType assetType,
) async {
  final filePath = 'scripts/populate/data/$fileName.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    print('Warning: $fileName.json not found, skipping.');
    print('  Run transform_raw_data.dart first to generate this file.');
    return;
  }

  print('Populating $fileName from $fileName.json...');

  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);

  if (items.isEmpty) {
    print('  Warning: $fileName.json is empty.');
    return;
  }

  // Load existing symbol+exchange combinations
  final existingResult = await connection.execute('SELECT symbol, exchange FROM asset');
  final existingKeys = <String>{};
  for (final row in existingResult) {
    final symbol = row[0] as String;
    final exchange = row[1] as String?;
    existingKeys.add(_makeKey(symbol, exchange));
  }

  final symbols = <String>[];
  final names = <String>[];
  final exchanges = <String?>[];
  final currencyIds = <int>[];
  final logoUrls = <String?>[];

  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    final exchange = (item['exchange'] as String?)?.trim();
    final key = _makeKey(symbol, exchange);

    if (AssetType.commodity != assetType && existingKeys.contains(key)) {
      skippedCount++;
      continue;
    }

    final name = (item['name'] as String?)?.trim() ?? symbol;
    final currencyCode = (item['currency'] as String?)?.trim().toUpperCase() ?? '';
    final logoUrl = item['logoUrl'] as String?;

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
    exchanges.add(exchange);
    currencyIds.add(currencyId);
    logoUrls.add(logoUrl);
  }

  if (symbols.isEmpty) {
    print('  $fileName.json: inserted 0, skipped $skippedCount, missing currency $missingCurrencyCount.');
    return;
  }

  await connection.execute(
    Sql.named('''
      INSERT INTO asset (id, symbol, "name", exchange, type, "logoUrl", "currencyId")
      SELECT gen_random_uuid(), symbol, name, exchange, @type, logo_url, currency_id
      FROM unnest(@symbols::text[], @names::text[], @exchanges::text[], @logoUrls::text[], @currencyIds::int[]) AS t(symbol, name, exchange, logo_url, currency_id)
      ON CONFLICT (symbol, exchange, type) DO NOTHING
    '''),
    parameters: {
      'symbols': TypedValue(Type.textArray, symbols),
      'names': TypedValue(Type.textArray, names),
      'exchanges': TypedValue(Type.textArray, exchanges),
      'type': assetType.name,
      'logoUrls': TypedValue(Type.textArray, logoUrls),
      'currencyIds': currencyIds,
    },
  );

  print('  $fileName.json: inserted ${symbols.length}, skipped $skippedCount, missing currency $missingCurrencyCount.');
}

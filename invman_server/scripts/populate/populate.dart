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

  final config = _loadConfig(env);
  final passwords = _loadPasswords(env);

  final connection = await _connectToDatabase(config, passwords);

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

Map<String, dynamic> _loadConfig(String env) {
  final configFile = File('config/$env.yaml');
  if (!configFile.existsSync()) {
    print('Config file not found: config/$env.yaml');
    exit(1);
  }

  final yaml = loadYaml(configFile.readAsStringSync()) as YamlMap;
  return _yamlMapToMap(yaml);
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
  Map<String, dynamic> config,
  Map<String, dynamic> passwords,
) async {
  final dbConfig = config['database'] as Map<String, dynamic>;
  final host = dbConfig['host'] as String;
  final port = dbConfig['port'] as int;
  final name = dbConfig['name'] as String;
  final user = dbConfig['user'] as String;
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

  var insertedCount = 0;
  var skippedCount = 0;

  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final code = row[codeIndex].toString().trim();
    if (code.isEmpty) continue;

    final existing = await connection.execute(
      Sql.named('SELECT id FROM currency WHERE code = @code'),
      parameters: {'code': code},
    );

    if (existing.isNotEmpty) {
      skippedCount++;
      continue;
    }

    await connection.execute(
      Sql.named(
        'INSERT INTO currency (code, "dollarValue", "timestamp", "updatedAt") VALUES (@code, 1.0, NOW() - INTERVAL \'1 day\', NOW() - INTERVAL \'1 day\')',
      ),
      parameters: {'code': code},
    );
    insertedCount++;
  }

  print('  Currencies: inserted $insertedCount, skipped $skippedCount (already exist).');
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

  var insertedCount = 0;
  var skippedCount = 0;
  var missingCurrencyCount = 0;

  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final symbol = row[symbolIndex].toString().trim();
    if (symbol.isEmpty) continue;

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

    final existing = await connection.execute(
      Sql.named('SELECT id FROM stock WHERE symbol = @symbol'),
      parameters: {'symbol': symbol},
    );

    if (existing.isNotEmpty) {
      skippedCount++;
      continue;
    }

    await connection.execute(
      Sql.named('''
        INSERT INTO stock (id, symbol, "name", "quoteType", "logoUrl", "price", "timestamp", "updatedAt", "currencyId")
        VALUES (gen_random_uuid(), @symbol, @name, @quoteType, @logoUrl, -1.0, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', @currencyId)
      '''),
      parameters: {
        'symbol': symbol,
        'name': name,
        'quoteType': stockType.name,
        'logoUrl': "https://raw.githubusercontent.com/nvstly/icons/refs/heads/main/ticker_icons/$symbol.png",
        'currencyId': currencyId,
      },
    );
    insertedCount++;
  }

  print(
    '  $fileName: inserted $insertedCount, skipped $skippedCount, '
    'missing currency $missingCurrencyCount.',
  );
}

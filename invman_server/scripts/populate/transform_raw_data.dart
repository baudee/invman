// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

import 's3_helper.dart';

const rawDataDir = 'scripts/populate/raw-data';
const outputDir = 'scripts/populate/data';
const batchSize = 2; // Number of items to process in parallel
const batchDelayMs = 100; // Delay in ms between batches (tune to avoid rate limits)
const saveInterval = 1000; // Save every N batches

late String apiKey;
late Set<String> validCurrencies;
late http.Client httpClient;

Future<void> main(List<String> args) async {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  apiKey = env['TWELVE_DATA_API_KEY'] ?? '';
  if (apiKey.isEmpty) {
    print('Error: TWELVE_DATA_API_KEY environment variable not set.');
    exit(1);
  }

  final s3AccessKey = env['S3_ACCESS_KEY'] ?? '';
  final s3SecretKey = env['S3_SECRET_KEY'] ?? '';
  if (s3AccessKey.isEmpty || s3SecretKey.isEmpty) {
    print('Error: S3_ACCESS_KEY and S3_SECRET_KEY environment variables must be set.');
    exit(1);
  }

  final s3 = createS3Client(s3AccessKey, s3SecretKey);

  // Sync raw-data and existing output from S3
  print('Downloading raw-data from S3...');
  await downloadS3Dir(s3, 'populate/raw-data', rawDataDir);

  print('Downloading existing processed data from S3 (for resume)...');
  await downloadS3Dir(s3, 'populate/data', outputDir);

  // Ensure output directory exists
  final outputDirFile = Directory(outputDir);
  if (!outputDirFile.existsSync()) {
    outputDirFile.createSync(recursive: true);
  }

  // Load valid currencies from currencies.json
  validCurrencies = _loadValidCurrencies();
  print('Loaded ${validCurrencies.length} valid currencies.');

  // Initialize shared HTTP client
  httpClient = http.Client();

  // Parse optional asset type argument
  final type = args.isNotEmpty ? args[0] : null;

  if (type == null || type == 'currencies') {
    await transformCurrencies();
  }
  if (type == null || type == 'stocks') {
    await transformStocks();
  }
  if (type == null || type == 'etfs') {
    await transformEtfs();
  }
  if (type == null || type == 'cryptos') {
    await transformCryptos();
  }
  if (type == null || type == 'commodities') {
    await transformCommodities();
  }

  // Close HTTP client
  httpClient.close();

  // Upload processed data to S3
  print('\nUploading processed data to S3...');
  await uploadDir(s3, outputDir, 'populate/data');

  print('\nTransformation completed!');
}

Set<String> _loadValidCurrencies() {
  final currencies = <String>{'USD'}; // Always include USD

  final file = File('$rawDataDir/currencies.json');
  if (!file.existsSync()) {
    print('Warning: currencies.json not found, using USD only.');
    return currencies;
  }

  final jsonContent = file.readAsStringSync();
  final Map<String, dynamic> parsed = jsonDecode(jsonContent);
  final List<dynamic> items = parsed['data'] ?? [];

  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    // Format is "USD/XXX" - extract the currency code after the slash
    if (symbol.startsWith('USD/') && symbol.length > 4) {
      final code = symbol.substring(4).toUpperCase();
      if (code.length == 3) {
        currencies.add(code);
      }
    }
  }

  return currencies;
}

Future<void> transformCurrencies() async {
  print('Transforming currencies...');

  // Reuse validCurrencies which is already loaded at startup
  final csvContent = 'code\n${validCurrencies.join('\n')}';
  await File('$outputDir/currencies.csv').writeAsString(csvContent);

  print('  Currencies: ${validCurrencies.length} codes extracted.');
}

Future<void> transformStocks() async {
  print('Transforming stocks...');

  final file = File('$rawDataDir/stocks.json');
  if (!file.existsSync()) {
    print('  Warning: stocks.json not found, skipping.');
    return;
  }

  final jsonContent = file.readAsStringSync();
  final Map<String, dynamic> parsed = jsonDecode(jsonContent);
  final List<dynamic> items = parsed['data'] ?? [];

  print('  Found ${items.length} stocks. Processing...');

  await _processAssetsGeneric(
    items,
    assetType: 'stocks',
    extractSymbol: (item) => (item['symbol'] as String?)?.trim() ?? '',
    extractName: (item) => (item['name'] as String?)?.trim(),
    extractCurrency: (item, _) => (item['currency'] as String?)?.trim().toUpperCase() ?? '',
    extractExchange: (item) => (item['exchange'] as String?)?.trim(),
  );
}

Future<void> transformEtfs() async {
  print('Transforming ETFs...');

  final file = File('$rawDataDir/etfs.json');
  if (!file.existsSync()) {
    print('  Warning: etfs.json not found, skipping.');
    return;
  }

  final jsonContent = file.readAsStringSync();
  final Map<String, dynamic> parsed = jsonDecode(jsonContent);
  final List<dynamic> items = parsed['data'] ?? [];

  print('  Found ${items.length} ETFs. Processing...');

  await _processAssetsGeneric(
    items,
    assetType: 'etfs',
    extractSymbol: (item) => (item['symbol'] as String?)?.trim() ?? '',
    extractName: (item) => (item['name'] as String?)?.trim(),
    extractCurrency: (item, _) => (item['currency'] as String?)?.trim().toUpperCase() ?? '',
    extractExchange: (item) => (item['exchange'] as String?)?.trim(),
  );
}

Future<void> transformCryptos() async {
  print('Transforming cryptos...');

  final file = File('$rawDataDir/cryptos.json');
  if (!file.existsSync()) {
    print('  Warning: cryptos.json not found, skipping.');
    return;
  }

  final jsonContent = file.readAsStringSync();
  final Map<String, dynamic> parsed = jsonDecode(jsonContent);
  final List<dynamic> items = parsed['data'] ?? [];

  print('  Found ${items.length} cryptos. Processing...');

  await _processAssetsGeneric(
    items,
    assetType: 'cryptos',
    extractSymbol: (item) => (item['symbol'] as String?)?.trim() ?? '',
    extractName: (item) => (item['currency_base'] as String?)?.trim(),
    extractExchange: (item) {
      final exchanges = item['available_exchanges'] as List<dynamic>?;
      return (exchanges != null && exchanges.isNotEmpty) ? (exchanges.first as String?)?.trim() : null;
    },
    extractCurrency: (item, symbol) => _extractCurrencyFromSymbol(symbol),
  );
}

Future<void> _saveAllWithFuture(
  File outputFile,
  Map<String, Map<String, dynamic>> processedItems,
  File futureFile,
  Map<String, Map<String, dynamic>> futureItems,
  File duplicationsFile,
  List<Map<String, dynamic>> duplications,
  File errorsFile,
  List<Map<String, dynamic>> errors,
) async {
  final futures = <Future<void>>[
    _saveOutput(outputFile, processedItems),
    if (futureItems.isNotEmpty)
      futureFile.writeAsString(const JsonEncoder.withIndent('  ').convert(futureItems.values.toList())),
    if (duplications.isNotEmpty)
      duplicationsFile.writeAsString(const JsonEncoder.withIndent('  ').convert(duplications)),
    if (errors.isNotEmpty) errorsFile.writeAsString(const JsonEncoder.withIndent('  ').convert(errors)),
  ];
  await Future.wait(futures);
}

Future<void> transformCommodities() async {
  print('Transforming commodities...');

  final file = File('$rawDataDir/commodities.json');
  if (!file.existsSync()) {
    print('  Warning: commodities.json not found, skipping.');
    return;
  }

  final jsonContent = file.readAsStringSync();
  final Map<String, dynamic> parsed = jsonDecode(jsonContent);
  final List<dynamic> items = parsed['data'] ?? [];

  print('  Found ${items.length} commodities. Processing...');

  // For commodities, we need to fetch currency and exchange from API
  await _processCommodities(items);
}

Future<void> _processAssetsGeneric(
  List<dynamic> items, {
  required String assetType,
  required String Function(dynamic) extractSymbol,
  required String? Function(dynamic) extractName,
  required String Function(dynamic item, String symbol) extractCurrency,
  required String? Function(dynamic) extractExchange,
}) async {
  final outputFile = File('$outputDir/$assetType.json');
  final futureFile = File('$outputDir/$assetType-future.json');
  final duplicationsFile = File('$outputDir/$assetType-duplications.json');
  final errorsFile = File('$outputDir/$assetType-errors.json');

  final (processedItems, futureItems, duplications, errors) = _loadExistingData(
    outputFile,
    futureFile,
    duplicationsFile,
    errorsFile,
  );

  final alreadyProcessedKeys = _buildProcessedKeys(processedItems, futureItems, duplications, errors);

  // Filter to unprocessed items only
  final unprocessedItems = <_ItemData>[];
  for (final item in items) {
    final symbol = extractSymbol(item);
    if (symbol.isEmpty) continue;
    final exchange = extractExchange(item);
    final key = _makeKey(symbol, exchange);
    if (alreadyProcessedKeys.contains(key)) continue;
    unprocessedItems.add(
      _ItemData(
        item: item,
        symbol: symbol,
        name: extractName(item) ?? symbol,
        currency: extractCurrency(item, symbol),
        exchange: exchange,
        key: key,
      ),
    );
  }

  print('  ${unprocessedItems.length} items to process...');

  var batchCount = 0;

  // Process in batches
  for (var i = 0; i < unprocessedItems.length; i += batchSize) {
    final batch = unprocessedItems.skip(i).take(batchSize).toList();
    batchCount++;

    // Step 1: Validate all items in parallel
    final validationResults = await Future.wait(
      batch.map((data) => _validateAsset(data.symbol, data.exchange)),
    );

    // Step 2: Collect items that need logos (valid and not duplicate)
    final itemsNeedingLogos = <_ItemData>[];

    for (var j = 0; j < batch.length; j++) {
      final data = batch[j];
      final validation = validationResults[j];

      if (validation.isError) {
        errors.add({
          'symbol': data.symbol,
          'name': data.name,
          'currency': data.currency,
          'exchange': data.exchange,
          'error': validation.errorMessage,
        });
      } else {
        final isValidCurrency = validCurrencies.contains(data.currency);
        final targetMap = isValidCurrency ? processedItems : futureItems;

        if (targetMap.containsKey(data.key)) {
          duplications.add({
            'symbol': data.symbol,
            'name': data.name,
            'currency': data.currency,
            'exchange': data.exchange,
          });
        } else {
          itemsNeedingLogos.add(data);
        }
      }
      alreadyProcessedKeys.add(data.key);
    }

    // Step 3: Fetch all logos in parallel
    if (itemsNeedingLogos.isNotEmpty) {
      final logoResults = await Future.wait(
        itemsNeedingLogos.map((data) => _fetchLogoUrl(data.symbol)),
      );

      for (var j = 0; j < itemsNeedingLogos.length; j++) {
        final data = itemsNeedingLogos[j];
        final logoUrl = logoResults[j];
        final isValidCurrency = validCurrencies.contains(data.currency);
        final targetMap = isValidCurrency ? processedItems : futureItems;

        targetMap[data.key] = {
          'symbol': data.symbol,
          'name': data.name,
          'currency': data.currency,
          'exchange': data.exchange,
          'logoUrl': logoUrl,
        };
      }
    }

    // Save periodically
    if (batchCount % saveInterval == 0) {
      print(
        '  Progress: ${processedItems.length} valid, ${futureItems.length} future, ${duplications.length} duplications, ${errors.length} errors.',
      );
      await _saveAllWithFuture(
        outputFile,
        processedItems,
        futureFile,
        futureItems,
        duplicationsFile,
        duplications,
        errorsFile,
        errors,
      );
    }

    // Wait
    await Future.delayed(Duration(milliseconds: batchDelayMs));
  }

  await _saveAllWithFuture(
    outputFile,
    processedItems,
    futureFile,
    futureItems,
    duplicationsFile,
    duplications,
    errorsFile,
    errors,
  );
  print(
    '  $assetType: ${processedItems.length} valid, ${futureItems.length} future, ${duplications.length} duplications, ${errors.length} errors.',
  );
}

Future<void> _processCommodities(List<dynamic> items) async {
  const assetType = 'commodities';
  final outputFile = File('$outputDir/$assetType.json');
  final futureFile = File('$outputDir/$assetType-future.json');
  final duplicationsFile = File('$outputDir/$assetType-duplications.json');
  final errorsFile = File('$outputDir/$assetType-errors.json');

  final (processedItems, futureItems, duplications, errors) = _loadExistingData(
    outputFile,
    futureFile,
    duplicationsFile,
    errorsFile,
  );

  final alreadyProcessedSymbols = _buildProcessedSymbols(processedItems, futureItems, duplications, errors);

  // Filter to unprocessed items only
  final unprocessedItems = <_CommodityData>[];
  for (final item in items) {
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;
    if (alreadyProcessedSymbols.contains(symbol)) continue;
    unprocessedItems.add(
      _CommodityData(
        symbol: symbol,
        name: (item['name'] as String?)?.trim() ?? symbol,
      ),
    );
  }

  print('  ${unprocessedItems.length} items to process...');

  var batchCount = 0;

  // Process in batches
  for (var i = 0; i < unprocessedItems.length; i += batchSize) {
    final batch = unprocessedItems.skip(i).take(batchSize).toList();
    batchCount++;

    // Step 1: Fetch commodity data (validation + currency/exchange) in parallel
    final apiResults = await Future.wait(
      batch.map((data) => _fetchCommodityData(data.symbol)),
    );

    // Step 2: Collect items that need logos
    final itemsNeedingLogos = <(String symbol, String name, String? currency, String? exchange, String key)>[];

    for (var j = 0; j < batch.length; j++) {
      final data = batch[j];
      final apiData = apiResults[j];
      final symbolCurrency = data.symbol.contains('/') ? _extractCurrencyFromSymbol(data.symbol) : null;

      if (apiData == null) {
        errors.add({
          'symbol': data.symbol,
          'name': data.name,
          'currency': symbolCurrency,
          'exchange': null,
          'error': 'API returned error or no data',
        });
      } else {
        final currency = symbolCurrency ?? apiData['currency'];
        final exchange = apiData['exchange'];
        final key = _makeKey(data.symbol, exchange);

        final isValidCurrency = currency != null && validCurrencies.contains(currency);
        final targetMap = isValidCurrency ? processedItems : futureItems;

        if (targetMap.containsKey(key)) {
          duplications.add({
            'symbol': data.symbol,
            'name': data.name,
            'currency': currency,
            'exchange': exchange,
          });
        } else {
          itemsNeedingLogos.add((data.symbol, data.name, currency, exchange, key));
        }
      }
      alreadyProcessedSymbols.add(data.symbol);
    }

    // Step 3: Fetch all logos in parallel
    if (itemsNeedingLogos.isNotEmpty) {
      final logoResults = await Future.wait(
        itemsNeedingLogos.map((item) => _fetchLogoUrl(item.$1)),
      );

      for (var j = 0; j < itemsNeedingLogos.length; j++) {
        final (symbol, name, currency, exchange, key) = itemsNeedingLogos[j];
        final logoUrl = logoResults[j];
        final isValidCurrency = currency != null && validCurrencies.contains(currency);
        final targetMap = isValidCurrency ? processedItems : futureItems;

        targetMap[key] = {
          'symbol': symbol,
          'name': name,
          'currency': currency,
          'exchange': exchange,
          'logoUrl': logoUrl,
        };
      }
    }

    // Save periodically
    if (batchCount % saveInterval == 0) {
      print(
        '  Progress: ${processedItems.length} valid, ${futureItems.length} future, ${duplications.length} duplications, ${errors.length} errors.',
      );
      await _saveAllWithFuture(
        outputFile,
        processedItems,
        futureFile,
        futureItems,
        duplicationsFile,
        duplications,
        errorsFile,
        errors,
      );
    }
  }

  await _saveAllWithFuture(
    outputFile,
    processedItems,
    futureFile,
    futureItems,
    duplicationsFile,
    duplications,
    errorsFile,
    errors,
  );
  print(
    '  commodities: ${processedItems.length} valid, ${futureItems.length} future, ${duplications.length} duplications, ${errors.length} errors.',
  );
}

String _makeKey(String? symbol, String? exchange) {
  return '${symbol ?? ''}:${exchange ?? ''}';
}

String _extractCurrencyFromSymbol(String symbol) {
  final slashIndex = symbol.indexOf('/');
  if (slashIndex != -1 && slashIndex < symbol.length - 1) {
    return symbol.substring(slashIndex + 1).toUpperCase();
  }
  return 'USD';
}

(
  Map<String, Map<String, dynamic>>,
  Map<String, Map<String, dynamic>>,
  List<Map<String, dynamic>>,
  List<Map<String, dynamic>>,
)
_loadExistingData(
  File outputFile,
  File futureFile,
  File duplicationsFile,
  File errorsFile,
) {
  final processedItems = <String, Map<String, dynamic>>{};
  final futureItems = <String, Map<String, dynamic>>{};
  final duplications = <Map<String, dynamic>>[];
  final errors = <Map<String, dynamic>>[];

  if (outputFile.existsSync()) {
    final existingContent = outputFile.readAsStringSync();
    final List<dynamic> existingItems = jsonDecode(existingContent);
    for (final item in existingItems) {
      final key = _makeKey(item['symbol'], item['exchange']);
      processedItems[key] = Map<String, dynamic>.from(item);
    }
    print('  Loaded ${processedItems.length} already processed items.');
  }

  if (futureFile.existsSync()) {
    final existingContent = futureFile.readAsStringSync();
    final List<dynamic> existingItems = jsonDecode(existingContent);
    for (final item in existingItems) {
      final key = _makeKey(item['symbol'], item['exchange']);
      futureItems[key] = Map<String, dynamic>.from(item);
    }
    print('  Loaded ${futureItems.length} future items.');
  }

  if (duplicationsFile.existsSync()) {
    final existingContent = duplicationsFile.readAsStringSync();
    final List<dynamic> existingItems = jsonDecode(existingContent);
    duplications.addAll(existingItems.map((e) => Map<String, dynamic>.from(e)));
  }

  if (errorsFile.existsSync()) {
    final existingContent = errorsFile.readAsStringSync();
    final List<dynamic> existingItems = jsonDecode(existingContent);
    errors.addAll(existingItems.map((e) => Map<String, dynamic>.from(e)));
  }

  return (processedItems, futureItems, duplications, errors);
}

Set<String> _buildProcessedKeys(
  Map<String, Map<String, dynamic>> processedItems,
  Map<String, Map<String, dynamic>> futureItems,
  List<Map<String, dynamic>> duplications,
  List<Map<String, dynamic>> errors,
) {
  final keys = <String>{};
  for (final item in processedItems.values) {
    keys.add(_makeKey(item['symbol'], item['exchange']));
  }
  for (final item in futureItems.values) {
    keys.add(_makeKey(item['symbol'], item['exchange']));
  }
  for (final item in duplications) {
    keys.add(_makeKey(item['symbol'], item['exchange']));
  }
  for (final item in errors) {
    keys.add(_makeKey(item['symbol'], item['exchange']));
  }
  return keys;
}

Set<String> _buildProcessedSymbols(
  Map<String, Map<String, dynamic>> processedItems,
  Map<String, Map<String, dynamic>> futureItems,
  List<Map<String, dynamic>> duplications,
  List<Map<String, dynamic>> errors,
) {
  final symbols = <String>{};
  for (final item in processedItems.values) {
    symbols.add(item['symbol'] as String);
  }
  for (final item in futureItems.values) {
    symbols.add(item['symbol'] as String);
  }
  for (final item in duplications) {
    symbols.add(item['symbol'] as String);
  }
  for (final item in errors) {
    symbols.add(item['symbol'] as String);
  }
  return symbols;
}

class _ItemData {
  final dynamic item;
  final String symbol;
  final String name;
  final String currency;
  final String? exchange;
  final String key;

  _ItemData({
    required this.item,
    required this.symbol,
    required this.name,
    required this.currency,
    required this.exchange,
    required this.key,
  });
}

class _CommodityData {
  final String symbol;
  final String name;

  _CommodityData({required this.symbol, required this.name});
}

class _ValidationResult {
  final bool isError;
  final String? errorMessage;

  _ValidationResult({required this.isError, this.errorMessage});
}

Future<_ValidationResult> _validateAsset(String symbol, String? exchange) async {
  try {
    var url =
        'https://api.twelvedata.com/time_series?symbol=$symbol&interval=1min&outputsize=1&apikey=$apiKey&type=Structured Product';
    if (exchange != null && exchange.isNotEmpty) {
      url += '&exchange=$exchange';
    }

    final uri = Uri.parse(url);
    final response = await httpClient.get(uri);

    if (response.statusCode != 200) {
      return _ValidationResult(isError: true, errorMessage: 'HTTP ${response.statusCode}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    // Check for API error response
    if (data['status'] == 'error' || data['code'] != null) {
      return _ValidationResult(isError: true, errorMessage: data['message'] ?? 'Unknown error');
    }

    // Check if meta exists (valid response)
    if (data['meta'] == null) {
      return _ValidationResult(isError: true, errorMessage: 'No meta in response');
    }

    return _ValidationResult(isError: false);
  } catch (e) {
    return _ValidationResult(isError: true, errorMessage: e.toString());
  }
}

Future<Map<String, String?>?> _fetchCommodityData(String symbol) async {
  try {
    final uri = Uri.parse(
      'https://api.twelvedata.com/time_series?symbol=$symbol&interval=1min&outputsize=1&apikey=$apiKey',
    );
    final response = await httpClient.get(uri);

    if (response.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    // Check for API error
    if (data['status'] == 'error' || data['code'] != null) {
      return null;
    }

    final meta = data['meta'] as Map<String, dynamic>?;
    if (meta == null) {
      return null;
    }

    String? currency = (meta['currency'] as String?)?.trim().toUpperCase();
    currency ??= (meta['currency_quote'] as String?)?.trim().toUpperCase();

    final exchange = (meta['exchange'] as String?)?.trim();

    return {
      'currency': currency,
      'exchange': exchange,
    };
  } catch (e) {
    return null;
  }
}

Future<String?> _fetchLogoUrl(String symbol) async {
  try {
    final uri = Uri.parse(
      'https://api.twelvedata.com/logo?symbol=$symbol&apikey=$apiKey',
    );
    final response = await httpClient.get(uri);

    if (response.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    String? logoUrl = data['url'] as String?;
    if (logoUrl == null || logoUrl.isEmpty) {
      logoUrl = data['logo_base'] as String?;
      if (logoUrl == null || logoUrl.isEmpty) {
        return null;
      }
    }
    return logoUrl;
  } catch (e) {
    return null;
  }
}

Future<void> _saveOutput(File file, Map<String, Map<String, dynamic>> data) async {
  final list = data.values.toList();
  final jsonString = const JsonEncoder.withIndent('  ').convert(list);
  await file.writeAsString(jsonString);
}

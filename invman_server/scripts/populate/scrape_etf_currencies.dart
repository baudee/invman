// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

const inputFile = 'scripts/populate/data/etfs.json';
const outputFile = 'scripts/populate/data/etfs_with_currency.json';

Future<void> main(List<String> args) async {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  final apiKey = env['FMP_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    print('Error: FMP_API_KEY environment variable not set.');
    exit(1);
  }

  final file = File(inputFile);
  if (!file.existsSync()) {
    print('Error: $inputFile not found.');
    exit(1);
  }

  print('Reading ETFs from $inputFile...');
  final jsonContent = file.readAsStringSync();
  final List<dynamic> items = jsonDecode(jsonContent);
  print('Found ${items.length} ETFs.');

  // Load existing output file to resume from where we left off
  final outputFileHandle = File(outputFile);
  final Map<String, Map<String, dynamic>> processedEtfs = {};

  if (outputFileHandle.existsSync()) {
    final existingContent = outputFileHandle.readAsStringSync();
    final List<dynamic> existingItems = jsonDecode(existingContent);
    for (final item in existingItems) {
      final symbol = item['symbol'] as String?;
      if (symbol != null) {
        processedEtfs[symbol] = Map<String, dynamic>.from(item);
      }
    }
    print('Loaded ${processedEtfs.length} already processed ETFs from $outputFile.');
  }

  // Rate limiting: 2500 requests per minute = ~41.67 requests per second
  // To be safe, we'll do 40 requests per second = 25ms between requests
  const requestDelayMs = 1;
  var requestCount = 0;
  var errorCount = 0;
  final startTime = DateTime.now();

  for (var i = 0; i < items.length; i++) {
    final item = items[i];
    final symbol = (item['symbol'] as String?)?.trim() ?? '';
    if (symbol.isEmpty) continue;

    // Skip if already processed
    if (processedEtfs.containsKey(symbol)) {
      continue;
    }

    final name = (item['name'] as String?)?.trim() ?? symbol;

    // Fetch currency from API
    final currency = await _fetchEtfCurrency(symbol, apiKey);
    requestCount++;

    if (currency != null) {
      processedEtfs[symbol] = {
        'symbol': symbol,
        'name': name,
        'currency': currency,
      };
    } else {
      errorCount++;
      processedEtfs[symbol] = {
        'symbol': symbol,
        'name': name,
        'currency': null,
      };
    }

    // Print progress every 100 requests
    if (requestCount % 100 == 0) {
      final elapsed = DateTime.now().difference(startTime).inSeconds;
      final rate = elapsed > 0 ? (requestCount / elapsed * 60).round() : requestCount;
      final remaining = items.length - processedEtfs.length;
      print(
        '  Progress: $requestCount API calls, ${processedEtfs.length}/${items.length} processed, ~$rate req/min, $remaining remaining',
      );

      // Save progress periodically
      await _saveOutput(outputFileHandle, processedEtfs);
    }

    // Rate limiting delay
    await Future.delayed(const Duration(milliseconds: requestDelayMs));
  }

  // Final save
  await _saveOutput(outputFileHandle, processedEtfs);

  final withCurrency = processedEtfs.values.where((e) => e['currency'] != null).length;
  final withoutCurrency = processedEtfs.values.where((e) => e['currency'] == null).length;

  print('');
  print('Done!');
  print('  Total ETFs: ${processedEtfs.length}');
  print('  With currency: $withCurrency');
  print('  Without currency: $withoutCurrency');
  print('  API errors during this run: $errorCount');
  print('  Output saved to: $outputFile');
}

Future<void> _saveOutput(File file, Map<String, Map<String, dynamic>> data) async {
  final list = data.values.toList();
  final jsonString = const JsonEncoder.withIndent('  ').convert(list);
  await file.writeAsString(jsonString);
}

Future<String?> _fetchEtfCurrency(String symbol, String apiKey) async {
  try {
    final uri = Uri.parse(
      'https://financialmodelingprep.com/stable/etf/info?symbol=$symbol&apikey=$apiKey',
    );
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return null;
    }

    final List<dynamic> data = jsonDecode(response.body);
    if (data.isEmpty) {
      return null;
    }

    return (data[0]['navCurrency'] as String?)?.trim();
  } catch (e) {
    return null;
  }
}

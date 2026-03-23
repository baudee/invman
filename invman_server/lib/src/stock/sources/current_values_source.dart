import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/services.dart';
import 'package:invman_server/src/stock/sources/sources.dart';

abstract class StockCurrentValuesSource {
  Future<StockCurrentValueOutput> getCurrentValue(StockCurrentValueInput input);
  Future<List<StockCurrentValueOutput>> getCurrentValues(List<StockCurrentValueInput> inputs);
}

@LazySingleton(as: StockCurrentValuesSource)
class StockCurrentValuesSourceImpl implements StockCurrentValuesSource {
  final GeminiClient _geminiClient;

  StockCurrentValuesSourceImpl(this._geminiClient);

  @override
  Future<StockCurrentValueOutput> getCurrentValue(StockCurrentValueInput input) async {
    final prompt =
        '''
Search for the current market price of ${input.name} (symbol: ${input.symbol}) in ${input.currencyCode}.
Return the price and the timestamp of when this price was recorded.
The timestamp should be in ISO 8601 format and include at least the hour.
If you cannot find current data, return value as -1.

Respond ONLY with a JSON object in this exact format, no other text:
{"value": <number>, "timestamp": "<ISO 8601 string>"}
''';

    var response = await _geminiClient.prompt(prompt);

    if (response == null) {
      return StockCurrentValueOutput(input.symbol, -1.0, DateTime.now());
    }

    if (response.startsWith('```json')) {
      response = response.replaceAll('```json', '').replaceAll('```', '').trim();
    }

    final json = jsonDecode(response);

    final value = json['value'];
    final timestamp = json['timestamp'];

    if (value == null || timestamp == null) {
      return StockCurrentValueOutput(input.symbol, -1.0, DateTime.now());
    }

    final parsedValue = (value is num) ? value.toDouble() : -1.0;
    if (parsedValue == -1.0) {
      return StockCurrentValueOutput(input.symbol, -1.0, DateTime.now());
    }

    final parsedTimestamp = DateTime.tryParse(timestamp.toString());
    if (parsedTimestamp == null) {
      return StockCurrentValueOutput(input.symbol, -1.0, DateTime.now());
    }

    return StockCurrentValueOutput(input.symbol, parsedValue, parsedTimestamp);
  }

  @override
  Future<List<StockCurrentValueOutput>> getCurrentValues(List<StockCurrentValueInput> inputs) async {
    final prompt =
        '''
Search for the current market price of the following stocks in their respective currencies:
${inputs.map((input) => "- ${input.name} (symbol: ${input.symbol}) in ${input.currencyCode}").join('\n')}
For each stock, return the symbol, the price and the timestamp of when this price was recorded.
The timestamp should be in ISO 8601 format and include at least the hour.
If you cannot find current data for a stock, return value as -1. 

Respond ONLY with a JSON array of objects in this exact format, no other text.:
[{"symbol": "<stock symbol>", "value": <number>, "timestamp": "<ISO 8601 string>"}]
''';

    var response = await _geminiClient.prompt(prompt);

    if (response == null) {
      return inputs.map((input) => StockCurrentValueOutput(input.symbol, -1.0, DateTime.now())).toList();
    }

    if (response.startsWith('```json')) {
      response = response.replaceAll('```json', '').replaceAll('```', '').trim();
    }

    final json = jsonDecode(response);

    if (json is! List) {
      return inputs.map((input) => StockCurrentValueOutput(input.symbol, -1.0, DateTime.now())).toList();
    }

    return inputs.map((input) {
      final stockData = json.firstWhere(
        (element) => element['symbol']?.toString().toUpperCase() == input.symbol.toUpperCase(),
        orElse: () => null,
      );

      if (stockData == null) {
        return StockCurrentValueOutput(input.symbol, -1.0, DateTime.now());
      }

      final value = stockData['value'];
      final timestamp = stockData['timestamp'];

      final parsedValue = (value is num) ? value.toDouble() : -1.0;
      final parsedTimestamp = DateTime.tryParse(timestamp?.toString() ?? '') ?? DateTime.now();

      return StockCurrentValueOutput(input.symbol, parsedValue, parsedTimestamp);
    }).toList();
  }
}

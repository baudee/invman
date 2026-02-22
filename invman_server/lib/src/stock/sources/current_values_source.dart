import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/services.dart';

abstract class StockCurrentValuesSource {
  Future<(double, DateTime)> getCurrentValue(String symbol, String name);
}

@LazySingleton(as: StockCurrentValuesSource)
class StockCurrentValuesSourceImpl implements StockCurrentValuesSource {
  final GeminiClient _geminiClient;

  StockCurrentValuesSourceImpl(this._geminiClient);

  @override
  Future<(double, DateTime)> getCurrentValue(String symbol, String name) async {
    final prompt = '''
Search for the current market price of $name (symbol: $symbol).
Return the price in USD and the timestamp of when this price was recorded.
The timestamp should be in ISO 8601 format and include at least the hour.
If you cannot find current data, return value as -1.

Respond ONLY with a JSON object in this exact format, no other text:
{"value": <number>, "timestamp": "<ISO 8601 string>"}
''';

    final response = await _geminiClient.prompt(prompt);

    if (response == null) {
      return (-1.0, DateTime.now());
    }

    final value = response['value'];
    final timestamp = response['timestamp'];

    if (value == null || timestamp == null) {
      return (-1.0, DateTime.now());
    }

    final parsedValue = (value is num) ? value.toDouble() : -1.0;
    if (parsedValue == -1.0) {
      return (-1.0, DateTime.now());
    }

    final parsedTimestamp = DateTime.tryParse(timestamp.toString());
    if (parsedTimestamp == null) {
      return (-1.0, DateTime.now());
    }

    return (parsedValue, parsedTimestamp);
  }
}

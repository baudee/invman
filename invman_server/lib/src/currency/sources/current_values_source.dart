import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/services.dart';

abstract class CurrencyCurrentValuesSource {
  Future<(double, DateTime)> getCurrentValue(String code);
}

@LazySingleton(as: CurrencyCurrentValuesSource)
class CurrencyCurrentValuesSourceImpl implements CurrencyCurrentValuesSource {
  final GeminiClient _geminiClient;

  CurrencyCurrentValuesSourceImpl(this._geminiClient);

  @override
  Future<(double, DateTime)> getCurrentValue(String code) async {
    final prompt = '''
Search for the current exchange rate of $code to USD.
Return the rate and the timestamp of when this rate was recorded.
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

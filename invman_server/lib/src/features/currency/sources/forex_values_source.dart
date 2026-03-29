import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/services.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';

abstract class ForexValuesSource {
  Future<AssetValue> getDollarValue({required String code});
  Future<AssetValue> getEodDollarValue({required String code, required DateTime date});
}

@LazySingleton(as: ForexValuesSource)
class ForexValuesSourceImpl implements ForexValuesSource {
  final Env _env;
  final String url = "api.twelvedata.com";
  final String timeSeriesPath = "time_series";
  final String eodPath = "eod";

  ForexValuesSourceImpl(this._env);

  @override
  Future<AssetValue> getDollarValue({required String code}) async {
    if (code == "USD") {
      return AssetValue(value: 1, timestamp: DateTime.now());
    }

    String requestCode = code;
    if (code == "ILA") {
      requestCode = "ILS";
    }

    final result = await ApiClientService.get(
      url: url,
      path: timeSeriesPath,
      queryParameters: {
        "symbol": "USD/$requestCode",
        "interval": "1min",
        "outputsize": "1",
        "apikey": _env.twelveDataApiKey,
        "timezone": "UTC",
      },
    );

    final twelveDataTimeSeries = TwelveDataTimeSeries.fromJson(result);

    if (twelveDataTimeSeries.values.isEmpty) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final data = twelveDataTimeSeries.values.first;
    double value = double.parse(data.close);
    if (code == "ILA") {
      value *= 100;
    }

    return AssetValue(value: value, timestamp: DateTime.parse(data.datetime));
  }

  @override
  Future<AssetValue> getEodDollarValue({required String code, required DateTime date}) async {
    if (code == "USD") {
      return AssetValue(value: 1, timestamp: date);
    }

    String requestCode = code;
    if (code == "ILA") {
      requestCode = "ILS";
    }

    final result = await ApiClientService.get(
      url: url,
      path: eodPath,
      queryParameters: {
        "symbol": "USD/$requestCode",
        "apikey": _env.twelveDataApiKey,
        "timezone": "UTC",
        "date": date.toString(),
      },
    );

    double value = double.parse(result['close']);
    if (code == "ILA") {
      value *= 100;
    }

    return AssetValue(value: value, timestamp: DateTime.parse(result['datetime']));
  }
}

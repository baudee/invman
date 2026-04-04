import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

abstract class ForexValuesSource {
  Future<AssetValue> getDollarValue(Session session, {required String code});
  Future<AssetValue> getEodDollarValue(Session session, {required String code, required DateTime date});
}

@LazySingleton(as: ForexValuesSource)
class ForexValuesSourceImpl implements ForexValuesSource {
  final Env _env;
  final String url = "api.twelvedata.com";
  final String timeSeriesPath = "time_series";
  final String eodPath = "eod";

  ForexValuesSourceImpl(this._env);

  @override
  Future<AssetValue> getDollarValue(Session session, {required String code}) async {
    final cacheKey = CacheKeys.currencyDollarValue(code);
    AssetValue? dollarValue = await session.caches.local.get(cacheKey);
    if (dollarValue == null) {
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

      dollarValue = AssetValue(value: value, timestamp: DateTime.parse(data.datetime));
      await session.caches.local.put(cacheKey, dollarValue, lifetime: Duration(seconds: 30));
    }
    return dollarValue;
  }

  @override
  Future<AssetValue> getEodDollarValue(Session session, {required String code, required DateTime date}) async {
    final cacheKey = CacheKeys.currencyEodDollarValue(code, date);
    AssetValue? dollarValue = await session.caches.local.get(cacheKey);
    if (dollarValue == null) {
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

      dollarValue = AssetValue(value: value, timestamp: DateTime.parse(result['datetime']));
      await session.caches.local.put(cacheKey, dollarValue, lifetime: Duration(days: 30));
    }
    return dollarValue;
  }
}

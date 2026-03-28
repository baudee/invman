import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/services.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';

abstract class AssetValuesSource {
  Future<AssetValue> getCurrentValue({required Asset asset});
  Future<List<AssetValue>> getValues({required Asset asset, required AssetTimeHorizon timeHorizon});
}

@LazySingleton(as: AssetValuesSource)
class AssetValuesSourceImpl implements AssetValuesSource {
  final Env _env;
  final String url = "api.twelvedata.com";
  final String path = "time_series";

  AssetValuesSourceImpl(this._env);

  @override
  Future<AssetValue> getCurrentValue({required Asset asset}) async {
    Map<String, String> queryParameters = {
      "symbol": asset.symbol,
      "interval": "1min",
      "outputsize": "1",
      "apikey": _env.twelveDataApiKey,
      "timezone": "UTC",
    };

    if (asset.exchange != null) {
      queryParameters["exchange"] = asset.exchange!;
    }

    final result = await ApiClientService.get(
      url: url,
      path: path,
      queryParameters: queryParameters,
    );

    final twelveDataTimeSeries = TwelveDataTimeSeries.fromJson(result);

    if (twelveDataTimeSeries.values.isEmpty) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final value = twelveDataTimeSeries.values.first;
    return AssetValue(value: double.parse(value.close), timestamp: DateTime.parse(value.datetime));
  }

  @override
  Future<List<AssetValue>> getValues({required Asset asset, required AssetTimeHorizon timeHorizon}) async {
    Map<String, String> queryParameters = {
      "symbol": asset.symbol,
      "interval": _getIntervalFromTimeHorizon(timeHorizon),
      "outputsize": "5000",
      "apikey": _env.twelveDataApiKey,
      "end_date": DateTime.timestamp().toString(),
      "timezone": "UTC",
    };

    if (timeHorizon != AssetTimeHorizon.all) {
      queryParameters["start_date"] = _getStartDateFromTimeHorizon(timeHorizon);
    }

    if (asset.exchange != null) {
      queryParameters["exchange"] = asset.exchange!;
    }

    final result = await ApiClientService.get(
      url: url,
      path: path,
      queryParameters: queryParameters,
    );

    final twelveDataTimeSeries = TwelveDataTimeSeries.fromJson(result);
    return twelveDataTimeSeries.values
        .map((e) => AssetValue(value: double.parse(e.close), timestamp: DateTime.parse(e.datetime)))
        .where((e) => e.timestamp.isAfter(DateTime(1971)))
        .toList();
  }

  String _getStartDateFromTimeHorizon(AssetTimeHorizon timeHorizon) {
    final now = DateTime.timestamp();
    switch (timeHorizon) {
      case AssetTimeHorizon.oneDay:
        return DateTime(now.year, now.month, now.day - 1).toString();
      case AssetTimeHorizon.oneWeek:
        return DateTime(now.year, now.month, now.day - 7).toString();
      case AssetTimeHorizon.oneMonth:
        return DateTime(now.year, now.month - 1, now.day).toString();
      case AssetTimeHorizon.oneYear:
        return DateTime(now.year - 1, now.month, now.day).toString();
      case AssetTimeHorizon.all:
        throw ServerException(errorCode: ErrorCode.badRequest);
    }
  }

  String _getIntervalFromTimeHorizon(AssetTimeHorizon timeHorizon) {
    switch (timeHorizon) {
      case AssetTimeHorizon.oneDay:
        return "5min";
      case AssetTimeHorizon.oneWeek:
        return "15min";
      case AssetTimeHorizon.oneMonth:
        return "2h";
      case AssetTimeHorizon.oneYear:
        return "1day";
      case AssetTimeHorizon.all:
        return "1month";
    }
  }
}

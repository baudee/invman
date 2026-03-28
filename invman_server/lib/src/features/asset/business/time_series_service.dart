import 'package:injectable/injectable.dart' hide Order;
import 'package:invman_server/src/features/asset/asset.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class TimeSeriesService {
  final AssetValuesSource assetsValuesSource;
  final AssetService assetService;
  TimeSeriesService(this.assetService, this.assetsValuesSource);

  Future<List<AssetValue>> get(Session session, UuidValue assetId, {required AssetTimeHorizon timeHorizon}) async {
    final asset = await assetService.retrieve(session, assetId);

    List<AssetValue>? timeSeries = await session.caches.local.get(_getCacheKey(asset, timeHorizon));

    if (timeSeries == null) {
      timeSeries = await assetsValuesSource.getValues(asset: asset, timeHorizon: timeHorizon);
      await session.caches.local.put(
        _getCacheKey(asset, timeHorizon),
        timeSeries,
        lifetime: _getDurationCachingFromTimeHorizon(timeHorizon),
      );
    }

    return timeSeries;
  }

  Duration _getDurationCachingFromTimeHorizon(AssetTimeHorizon timeHorizon) {
    switch (timeHorizon) {
      case AssetTimeHorizon.oneDay:
        return Duration(minutes: 1);
      case AssetTimeHorizon.oneWeek:
        return Duration(hours: 1);
      case AssetTimeHorizon.oneMonth:
        return Duration(hours: 6);
      case AssetTimeHorizon.oneYear:
        return Duration(hours: 6);
      case AssetTimeHorizon.all:
        return Duration(days: 1);
    }
  }

  String _getCacheKey(Asset asset, AssetTimeHorizon timeHorizon) {
    return "${asset.id}-${timeHorizon.name}";
  }
}

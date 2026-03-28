import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@lazySingleton
class TimeSeriesRepository {
  final Client client;

  TimeSeriesRepository(this.client);

  Future<Either<String, List<AssetValue>>> get(UuidValue id, {required AssetTimeHorizon timeHorizon}) async {
    return safeCall(() async {
      return right(await client.asset.timeseries(id, timeHorizon: timeHorizon));
    });
  }
}

import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/features/asset/asset.dart';
import 'package:serverpod/serverpod.dart';

class AssetEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<void> like(Session session, UuidValue assetId) async {
    return withMiddleware(
      session,
      () => getIt<LikeService>().like(session, assetId),
    );
  }

  Future<void> unlike(Session session, UuidValue assetId) async {
    return withMiddleware(
      session,
      () => getIt<LikeService>().unlike(session, assetId),
    );
  }

  Future<Asset> retrieve(Session session, UuidValue uuid) async {
    return withMiddleware(
      session,
      () => getIt<AssetService>().retrieve(session, uuid),
    );
  }

  Future<List<Asset>> list(
    Session session, {
    AssetFilter? filter,
    int limit = 10,
    int page = 1,
  }) async {
    return withMiddleware(
      session,
      () => getIt<AssetService>().list(
        session,
        filter: filter ?? AssetFilter(),
        limit: limit,
        page: page,
      ),
    );
  }

  Future<List<AssetValue>> timeseries(
    Session session,
    UuidValue assetId, {
    required AssetTimeHorizon timeHorizon,
  }) async {
    return withMiddleware(
      session,
      () => getIt<TimeSeriesService>().get(
        session,
        assetId,
        timeHorizon: timeHorizon,
      ),
    );
  }

  Future<List<String>> exchanges(Session session) async {
    return withMiddleware(session, () => getIt<ExchangeService>().listAll(session));
  }
}

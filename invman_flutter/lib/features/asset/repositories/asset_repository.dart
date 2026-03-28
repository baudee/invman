import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class AssetRepository {
  final Client client;

  final _invalidationLikedAssets = signal(false);
  ReadonlySignal<bool> get invalidationLikedAssets => _invalidationLikedAssets;

  void _notifyLikeChange() => _invalidationLikedAssets.value = !_invalidationLikedAssets.value;

  AssetRepository(this.client);

  Future<Either<String, Asset>> retrieve(UuidValue uuid) async {
    return safeCall(() async {
      return right(await client.asset.retrieve(uuid));
    });
  }

  Future<Either<String, void>> like(UuidValue assetId) async {
    return safeCall(() async {
      await client.asset.like(assetId);
      _notifyLikeChange();
      return right(null);
    });
  }

  Future<Either<String, void>> unlike(UuidValue assetId) async {
    return safeCall(() async {
      await client.asset.unlike(assetId);
      _notifyLikeChange();
      return right(null);
    });
  }

  Future<Either<String, List<Asset>>> list({AssetFilter? filter, int limit = 10, int page = 1}) async {
    return safeCall(() async {
      return right(await client.asset.list(filter: filter, limit: limit, page: page));
    });
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/pagination_controller.dart';
import 'package:invman_flutter/features/asset/repositories/asset_repository.dart';

@injectable
class LikedAssetListController extends PaginationController<Asset> {
  final AssetRepository _repository;

  LikedAssetListController(this._repository) : super() {
    _repository.invalidationLikedAssets.subscribe((_) {
      refresh();
    });
  }

  @override
  Future<Either<String, List<Asset>>> fetchPage(int page, int limit) {
    return _repository.list(filter: AssetFilter(favorite: true), page: page, limit: limit);
  }
}

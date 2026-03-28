import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/pagination_controller.dart';
import 'package:invman_flutter/features/asset/repositories/asset_repository.dart';

@injectable
class PopularAssetListController extends PaginationController<Asset> {
  final AssetType _type;
  final AssetRepository _repository;

  PopularAssetListController(@factoryParam this._type, this._repository);

  @override
  Future<Either<String, List<Asset>>> fetchPage(int page, int limit) {
    return _repository.list(
      filter: AssetFilter(type: _type),
      page: page,
      limit: limit,
    );
  }
}

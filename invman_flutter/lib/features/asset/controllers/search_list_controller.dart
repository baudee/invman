import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/repositories/asset_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AssetSearchListController extends PaginationController<Asset> {
  final query = Signal<String>('');

  final AssetRepository _repository;

  EffectCleanup? _cleanup;
  String _lastQuery = '';

  AssetSearchListController(this._repository) {
    _lastQuery = query.value;
    _cleanup = effect(() {
      final q = query.value;
      if (q != _lastQuery) {
        _lastQuery = q;
        refresh();
      }
    });
  }

  @override
  void dispose() {
    _cleanup?.call();
  }

  @override
  Future<Either<String, List<Asset>>> fetchPage(int page, int limit) {
    if (query.value.isEmpty) {
      return Future.value(const Right([]));
    }
    return _repository.list(
      filter: AssetFilter(query: query.value),
      page: page,
      limit: limit,
    );
  }
}

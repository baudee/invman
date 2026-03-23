import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockSearchListController extends PaginationController<Stock> {
  final query = Signal<String>('');

  final StockRepository _repository;

  EffectCleanup? _cleanup;
  String _lastQuery = '';

  StockSearchListController(this._repository) {
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
  Future<Either<String, List<Stock>>> fetchPage(int page, int limit) {
    if (query.value.isEmpty) {
      return Future.value(const Right([]));
    }
    return _repository.list(
      filter: StockFilter(query: query.value),
      page: page,
      limit: limit,
    );
  }
}

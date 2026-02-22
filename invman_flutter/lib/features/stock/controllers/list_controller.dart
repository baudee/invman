import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockSearchListController extends PaginationController<Stock> {
  final query = Signal<String>('');

  final StockRepository _service;

  EffectCleanup? _cleanup;
  String _lastQuery = '';

  StockSearchListController(this._service) {
    _lastQuery = query.value;
    _cleanup = effect(() {
      final q = query.value;
      if (q != _lastQuery) {
        _lastQuery = q;
        refresh();
      }
    });
  }

  void dispose() {
    _cleanup?.call();
  }

  @override
  Future<Either<String, List<Stock>>> fetchPage(int page) {
    return _service.search(query: query.value, page: page, limit: 10);
  }
}

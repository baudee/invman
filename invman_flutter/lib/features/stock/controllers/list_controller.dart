import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockSearchListController extends PaginationController<Stock> {
  final StockRepository _service;

  final FlutterSignal<String> query = signal("");

  StockSearchListController(this._service);

  @override
  Future<Either<String, List<Stock>>> fetchPage(int page) {
    return _service.search(query: query.value, page: page, limit: 10);
  }
}

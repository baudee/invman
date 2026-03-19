import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/pagination_controller.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';

@injectable
class LikedStockListController extends PaginationController<Stock> {
  final StockRepository _repository;

  LikedStockListController(this._repository) : super() {
    _repository.invalidationLikedStocks.subscribe((_) {
      refresh();
    });
  }

  @override
  Future<Either<String, List<Stock>>> fetchPage(int page) {
    return _repository.listLiked(page: page, limit: 10);
  }
}

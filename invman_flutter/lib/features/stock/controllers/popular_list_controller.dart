import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/pagination_controller.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';

@injectable
class PopularStockListController extends PaginationController<Stock> {
  final StockRepository _repository;

  PopularStockListController(this._repository);

  @override
  Future<Either<String, List<Stock>>> fetchPage(int page) {
    return _repository.listPopular(page: page, limit: 10);
  }
}

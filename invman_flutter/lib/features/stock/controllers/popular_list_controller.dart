import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/pagination_controller.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';

@injectable
class PopularStockListController extends PaginationController<Stock> {
  final StockType _type;
  final StockRepository _repository;

  PopularStockListController(@factoryParam this._type, this._repository);

  @override
  Future<Either<String, List<Stock>>> fetchPage(int page, int limit) {
    return _repository.list(
      filter: StockFilter(type: _type),
      page: page,
      limit: limit,
    );
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';

@injectable
class StockDetailController extends DetailController<UuidValue, Stock> {
  final StockRepository _service;

  StockDetailController(@factoryParam super.id, this._service);

  @override
  Future<Either<String, Stock>> retrieve(UuidValue id) {
    return _service.retrieve(id);
  }
}

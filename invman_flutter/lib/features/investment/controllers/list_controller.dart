import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';

@injectable
class InvestmentListController extends PaginationController<Investment> {
  final InvestmentRepository _repository;

  InvestmentListController(this._repository) : super() {
    _repository.invalidation.subscribe((_) => refresh());
  }

  @override
  Future<Either<String, List<Investment>>> fetchPage(int page) {
    return _repository.list(page: page, limit: 10);
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/dividend/repositories/dividend_repository.dart';

@injectable
class DividendListController extends PaginationController<ComputedDividendValue> {
  final DividendRepository _repository;

  DividendListController(this._repository);

  @override
  Future<Either<String, List<ComputedDividendValue>>> fetchPage(int page, int limit) {
    return _repository.list(page: page, limit: limit);
  }
}

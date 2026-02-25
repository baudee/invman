import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:signals_flutter/signals_core.dart';

@injectable
class InvestmentListController extends PaginationController<Investment> {
  final InvestmentRepository _repository;
  final Signal<Investment?> total = signal(null);

  InvestmentListController(this._repository) : super() {
    _repository.invalidation.subscribe((_) {
      refresh();
      loadTotal();
    });
  }

  @override
  Future<Either<String, List<Investment>>> fetchPage(int page) {
    return _repository.list(page: page, limit: 10);
  }

  Future<void> loadTotal() async {
    final result = await _repository.total();
    result.fold((l) => null, (total) => this.total.value = total);
  }
}

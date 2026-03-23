import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:signals_flutter/signals_core.dart';

@injectable
class InvestmentListController extends PaginationController<Investment> {
  final InvestmentRepository _repository;
  final Signal<Investment?> _total = signal(null);
  ReadonlySignal<Investment?> get total => _total;

  InvestmentListController(this._repository) : super(fireImmediately: false) {
    _repository.invalidation.subscribe((_) {
      print('Investment invalidation listened in controller');
      loadTotal().then((_) => refresh());
    });
  }

  @override
  Future<Either<String, List<Investment>>> fetchPage(int page, int limit) {
    return _repository.list(page: page, limit: limit);
  }

  Future<void> loadTotal() async {
    final result = await _repository.total();
    result.fold((l) => null, (t) => _total.value = t);
  }
}

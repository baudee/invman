import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/controllers/returns_provider.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:invman_flutter/features/investment/repositories/returns_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentListController extends PaginationController<Investment> implements ReturnsProvider {
  final InvestmentRepository _repository;
  final ReturnsRepository _returnsRepository;
  final Signal<Investment?> _total = signal(null);
  ReadonlySignal<Investment?> get total => _total;

  final Map<InvestmentReturnInterval, AsyncSignal<List<InvestmentReturn>>> _returnsList = {};

  InvestmentListController(this._repository, this._returnsRepository) : super(fireImmediately: false) {
    _repository.invalidation.subscribe((_) {
      _returnsList.clear();
      loadTotal();
      refresh();
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

  @override
  ReadonlySignal<AsyncState<List<InvestmentReturn>>> getReturnsFromInterval(InvestmentReturnInterval interval) {
    if (_returnsList.containsKey(interval)) {
      return _returnsList[interval]!.readonly();
    } else {
      final s = asyncSignal<List<InvestmentReturn>>(AsyncState.loading());
      _returnsList[interval] = s;
      _returnsRepository.getTotal(interval: interval).then((result) {
        result.fold(
          (error) {},
          (returns) {
            s.value = AsyncState.data(returns);
          },
        );
        _returnsList[interval] = s;
      });
      return s.readonly();
    }
  }

  @override
  void reloadReturns(InvestmentReturnInterval interval) {
    if (_returnsList.containsKey(interval)) {
      _returnsList[interval]!.value = AsyncState.loading();
      _returnsRepository.getTotal(interval: interval).then((result) {
        result.fold(
          (error) => null,
          (returns) => _returnsList[interval]!.value = AsyncState.data(returns),
        );
      });
    }
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentListController extends PaginationController<Investment> implements ReturnsProvider {
  final InvestmentRepository _repository;
  final InvestmentCountRepository _countRepository;
  final ReturnsRepository _returnsRepository;
  final Signal<Investment?> _total = signal(null);
  ReadonlySignal<Investment?> get total => _total;

  final Map<InvestmentReturnInterval, AsyncSignal<List<InvestmentReturn>>> _returnsList = {};

  InvestmentListController(this._repository, this._countRepository, this._returnsRepository)
    : super(fireImmediately: false) {
    _repository.invalidation.subscribe((_) {
      reload();
    });
  }

  @override
  Future<Either<String, List<Investment>>> fetchPage(int page, int limit) async {
    final result = await _repository.list(page: page, limit: limit);
    if (page == 1) {
      result.fold((error) => null, (list) => _countRepository.setCount(list.length));
    }
    return result;
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

  Future<void> reload() async {
    _returnsList.clear();
    loadTotal();
    refresh();
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

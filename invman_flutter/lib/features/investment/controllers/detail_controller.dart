import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:invman_flutter/features/investment/repositories/returns_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentDetailController extends DetailController<int, Investment> {
  final InvestmentRepository _repository;
  final ReturnsRepository _returnsRepository;

  final Map<InvestmentReturnInterval, FlutterSignal<List<InvestmentReturn>>> _returnsList = {};

  InvestmentDetailController(@factoryParam super.id, this._repository, this._returnsRepository)
    : super(fireImmediately: false) {
    _repository.invalidation.subscribe((_) => reload());
  }

  @override
  Future<Either<String, Investment>> retrieve(int id) {
    return _repository.retrieve(id);
  }

  Future<(bool, String?)> delete() => DeleteCommand(onExecute: () => _repository.delete(id)).execute();

  ReadonlySignal<List<InvestmentReturn>> getReturnsFromInterval(InvestmentReturnInterval interval) {
    if (_returnsList.containsKey(interval)) {
      return _returnsList[interval]!;
    } else {
      final s = signal<List<InvestmentReturn>>([]);
      _returnsList[interval] = s;
      _returnsRepository.get(id, interval: interval).then((result) {
        result.fold(
          (error) {},
          (returns) {
            s.value = returns;
          },
        );
        _returnsList[interval] = s;
      });
      return s.readonly();
    }
  }

  @override
  Future<void> reload() async {
    super.reload();
    _returnsList.clear();
  }

  @override
  void onDispose() {
    super.onDispose();
    _returnsList.forEach((_, signal) => signal.dispose());
  }
}

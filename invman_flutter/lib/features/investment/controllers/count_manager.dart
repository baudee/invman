import 'package:injectable/injectable.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class InvestmentCountManager {
  final InvestmentCountRepository _repository;
  late final ReadonlySignal<int?> count;

  InvestmentCountManager(this._repository) {
    count = _repository.count;
    if (count.value == null) {
      _repository.refresh();
    }
  }
}

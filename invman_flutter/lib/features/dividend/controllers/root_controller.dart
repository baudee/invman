import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/dividend/dividend.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class DividendController implements Disposable {
  final DividendRepository _repository;
  final TransferRepository _transferRepository;

  final _calendar = asyncSignal<List<ComputedDividendValue>>(AsyncState.loading());
  final _history = asyncSignal<List<TotalDividendYear>>(AsyncState.loading());
  final _selectedCurrency = signal('');
  ReadonlySignal<String> get selectedCurrency => _selectedCurrency;

  late final _state = computed<AsyncState<DividendData>>(() {
    final cal = _calendar.value;
    final hist = _history.value;
    if (cal.isLoading || hist.isLoading) return AsyncState.loading();
    if (cal.hasError) return AsyncState.error(cal.error!);
    if (hist.hasError) return AsyncState.error(hist.error!);
    return AsyncState.data(DividendData(calendar: cal.requireValue, history: hist.requireValue));
  });

  ReadonlySignal<AsyncState<DividendData>> get state => _state;

  DividendController(this._repository, this._transferRepository) {
    _transferRepository.invalidation.subscribe((_) => reload());
  }

  void setSelectedCurrency(String currency) {
    _selectedCurrency.value = currency;
  }

  Future<void> _loadCalendar() async {
    _calendar.value = AsyncState.loading();

    final result = await _repository.calendar();
    result.fold(
      (error) => _calendar.value = AsyncState.error(error),
      (data) {
        final currencies = data.map((e) => e.investment.asset?.currency?.code ?? '?').toSet().toList()..sort();
        _selectedCurrency.value = currencies.isNotEmpty ? currencies.first : '';
        _calendar.value = AsyncState.data(data);
      },
    );
  }

  Future<void> _loadHistory() async {
    _history.value = AsyncState.loading();

    final now = DateTime.timestamp();

    final result = await _repository.total(now.year - 10, now.year - 1);
    result.fold(
      (error) => _history.value = AsyncState.error(error),
      (data) => _history.value = AsyncState.data(data),
    );
  }

  void reload() {
    _loadCalendar();
    _loadHistory();
  }

  @override
  void onDispose() {
    _selectedCurrency.dispose();
    _calendar.dispose();
    _history.dispose();
  }
}

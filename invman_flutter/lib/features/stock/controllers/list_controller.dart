import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/services/stock_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class StockSearchListController {
  final StockService _service;

  late final AsyncSignal<List<Stock>> state;

  StockSearchListController(this._service) {
    state = futureSignal(() async => <Stock>[]);
  }

  Future<void> search(String query) async {
    state.value = AsyncLoading();
    final result = await _service.search(query: query);
    result.fold(
      (error) => state.value = AsyncError(error, StackTrace.current),
      (data) => state.value = AsyncData(data.results),
    );
  }

  void clear() {
    state.value = AsyncData(<Stock>[]);
  }

  void dispose() {
    state.dispose();
  }
}

import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockRootController {
  final StockRepository _repository;
  final AsyncSignal<List<Stock>> popularStocks = AsyncSignal<List<Stock>>(AsyncState.loading());
  final AsyncSignal<List<Stock>> likedStocks = AsyncSignal<List<Stock>>(AsyncState.loading());

  StockRootController(this._repository) {
    _fetch();
  }

  Future<void> _fetch() async {
    popularStocks.value = AsyncState.loading();
    likedStocks.value = AsyncState.loading();

    final popularResult = await _repository.listPopular(limit: 10, page: 1);
    popularResult.fold((error) => popularStocks.value = AsyncState.error(error), (stocks) {
      popularStocks.value = AsyncState.data(stocks);
    });

    final likedResult = await _repository.listLiked(limit: 10, page: 1);
    likedResult.fold((error) => likedStocks.value = AsyncState.error(error), (stocks) {
      likedStocks.value = AsyncState.data(stocks);
    });
  }

  Future<void> reload() => _fetch();
}

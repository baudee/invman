import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockRootController {
  final StockRepository _repository;

  final AsyncSignal<List<Stock>> _popularStocks = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get popularStocks => _popularStocks;
  final AsyncSignal<List<Stock>> _likedStocks = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get likedStocks => _likedStocks;

  StockRootController(this._repository) : super() {
    fetchPopularStocks();
    _repository.invalidationLikedStocks.subscribe((_) {
      fetchLikedStocks();
    });
  }

  Future<void> fetchLikedStocks() async {
    _likedStocks.value = AsyncState.loading();

    final likedResult = await _repository.listLiked(limit: 10, page: 1);
    likedResult.fold((error) => _likedStocks.value = AsyncState.error(error), (stocks) {
      _likedStocks.value = AsyncState.data(stocks);
    });
  }

  Future<void> fetchPopularStocks() async {
    _popularStocks.value = AsyncState.loading();

    final popularResult = await _repository.listPopular(limit: 10, page: 1);
    popularResult.fold((error) => _popularStocks.value = AsyncState.error(error), (stocks) {
      _popularStocks.value = AsyncState.data(stocks);
    });
  }
}

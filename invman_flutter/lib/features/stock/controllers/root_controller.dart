import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/repositories/stock_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class StockRootController {
  final StockRepository _repository;

  final AsyncSignal<List<Stock>> _likedStocks = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get likedStocks => _likedStocks;
  final AsyncSignal<List<Stock>> _popularStocks = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get popularStocks => _popularStocks;
  final AsyncSignal<List<Stock>> _popularETFs = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get popularETFs => _popularETFs;
  final AsyncSignal<List<Stock>> _popularIndices = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get popularIndices => _popularIndices;
  final AsyncSignal<List<Stock>> _popularCryptos = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get popularCryptos => _popularCryptos;
  final AsyncSignal<List<Stock>> _popularCommodities = AsyncSignal<List<Stock>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Stock>>> get popularCommodities => _popularCommodities;

  StockRootController(this._repository) : super() {
    fetchPopularStocks();
    fetchPopularETFs();
    fetchPopularIndices();
    fetchPopularCryptos();
    fetchPopularCommodities();

    _repository.invalidationLikedStocks.subscribe((_) {
      fetchLikedStocks();
    });
  }

  Future<void> fetchLikedStocks() async {
    _likedStocks.value = AsyncState.loading();

    final likedResult = await _repository.list(filter: StockFilter(favorite: true));
    likedResult.fold((error) => _likedStocks.value = AsyncState.error(error), (stocks) {
      _likedStocks.value = AsyncState.data(stocks);
    });
  }

  Future<void> _fetchPopular(AsyncSignal<List<Stock>> signal, StockType type) async {
    signal.value = AsyncState.loading();
    final popularResult = await _repository.list(filter: StockFilter(type: type));
    popularResult.fold((error) => signal.value = AsyncState.error(error), (stocks) {
      signal.value = AsyncState.data(stocks);
    });
  }

  Future<void> fetchPopularStocks() async {
    _fetchPopular(_popularStocks, .stock);
  }

  Future<void> fetchPopularETFs() async {
    _fetchPopular(_popularETFs, .etf);
  }

  Future<void> fetchPopularIndices() async {
    _fetchPopular(_popularIndices, .indice);
  }

  Future<void> fetchPopularCryptos() async {
    _fetchPopular(_popularCryptos, .crypto);
  }

  Future<void> fetchPopularCommodities() async {
    _fetchPopular(_popularCommodities, .commodity);
  }
}

import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/asset/repositories/asset_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AssetRootController {
  final AssetRepository _repository;

  final AsyncSignal<List<Asset>> _likedAssets = AsyncSignal<List<Asset>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Asset>>> get likedAssets => _likedAssets;
  final AsyncSignal<List<Asset>> _popularAssets = AsyncSignal<List<Asset>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Asset>>> get popularAssets => _popularAssets;
  final AsyncSignal<List<Asset>> _popularETFs = AsyncSignal<List<Asset>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Asset>>> get popularETFs => _popularETFs;
  final AsyncSignal<List<Asset>> _popularCryptos = AsyncSignal<List<Asset>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Asset>>> get popularCryptos => _popularCryptos;
  final AsyncSignal<List<Asset>> _popularCommodities = AsyncSignal<List<Asset>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Asset>>> get popularCommodities => _popularCommodities;

  AssetRootController(this._repository) : super() {
    fetchPopularAssets();
    fetchPopularETFs();
    fetchPopularCryptos();
    fetchPopularCommodities();

    _repository.invalidationLikedAssets.subscribe((_) {
      fetchLikedAssets();
    });
  }

  Future<void> fetchLikedAssets() async {
    _likedAssets.value = AsyncState.loading();

    final likedResult = await _repository.list(filter: AssetFilter(favorite: true));
    likedResult.fold((error) => _likedAssets.value = AsyncState.error(error), (assets) {
      _likedAssets.value = AsyncState.data(assets);
    });
  }

  Future<void> _fetchPopular(AsyncSignal<List<Asset>> signal, AssetType type) async {
    signal.value = AsyncState.loading();
    final popularResult = await _repository.list(filter: AssetFilter(type: type));
    popularResult.fold((error) => signal.value = AsyncState.error(error), (assets) {
      signal.value = AsyncState.data(assets);
    });
  }

  Future<void> fetchPopularAssets() async {
    _fetchPopular(_popularAssets, .stock);
  }

  Future<void> fetchPopularETFs() async {
    _fetchPopular(_popularETFs, .etf);
  }

  Future<void> fetchPopularCryptos() async {
    _fetchPopular(_popularCryptos, .crypto);
  }

  Future<void> fetchPopularCommodities() async {
    _fetchPopular(_popularCommodities, .commodity);
  }
}

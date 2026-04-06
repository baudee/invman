import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/asset.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AssetDetailController extends DetailController<UuidValue, Asset> {
  final AssetRepository _repository;
  final TimeSeriesRepository _timeSeriesRepository;

  final Map<AssetTimeHorizon, AsyncSignal<List<AssetValue>>> _timeSeriesList = {};

  AssetDetailController(@factoryParam super.id, this._repository, this._timeSeriesRepository);

  @override
  Future<Either<String, Asset>> retrieve(UuidValue id) {
    return _repository.retrieve(id);
  }

  Future<String?> toggleLike() async {
    if (super.state.value case AsyncData(value: final asset)) {
      final wasLiked = asset.isLiked;
      final previousLikes = asset.likes;

      final optimisticLikes = wasLiked
          ? <AssetLike>[]
          : [AssetLike(userId: UuidValue.fromString(Namespace.nil.value), assetId: asset.id)];
      updateState(asset.copyWith(likes: optimisticLikes));

      final result = wasLiked ? await _repository.unlike(asset.id) : await _repository.like(asset.id);

      return result.fold((error) {
        updateState(asset.copyWith(likes: previousLikes));
        return error;
      }, (_) => null);
    }
    return S.current.error_invalidState;
  }

  ReadonlySignal<AsyncState<List<AssetValue>>> getTimeseriesFromTimeHorizon(AssetTimeHorizon timeHorizon) {
    if (_timeSeriesList.containsKey(timeHorizon)) {
      return _timeSeriesList[timeHorizon]!.readonly();
    } else {
      final s = asyncSignal<List<AssetValue>>(AsyncState.loading());
      _timeSeriesList[timeHorizon] = s;
      _timeSeriesRepository.get(id, timeHorizon: timeHorizon).then((result) {
        result.fold(
          (error) {},
          (timeSeries) {
            s.value = AsyncState.data(timeSeries);
          },
        );
        _timeSeriesList[timeHorizon] = s;
      });
      return s.readonly();
    }
  }

  void reloadTimeseries(AssetTimeHorizon horizon) {
    if (_timeSeriesList.containsKey(horizon)) {
      _timeSeriesList[horizon]!.value = AsyncState.loading();
      _timeSeriesRepository.get(id, timeHorizon: horizon).then((result) {
        result.fold(
          (error) => null,
          (returns) => _timeSeriesList[horizon]!.value = AsyncState.data(returns),
        );
      });
    }
  }

  @override
  Future<void> reload() async {
    super.reload();
    _timeSeriesList.clear();
  }

  @override
  void onDispose() {
    super.onDispose();
    _timeSeriesList.forEach((_, signal) => signal.dispose());
  }
}

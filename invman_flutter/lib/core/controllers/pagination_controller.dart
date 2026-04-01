import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class PaginationController<T> extends Disposable {
  final _state = asyncSignal<List<T>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<T>>> get state => _state.readonly();

  final _pageNumberSignal = signal(1);
  final _isLastPageSignal = signal(false);
  ReadonlySignal<bool> get isLastPage => _isLastPageSignal;
  late final _eligibleForFetchingData = computed(() => !_state.value.isLoading && !_isLastPageSignal.value);
  ReadonlySignal<bool> get eligibleForFetchingData => _eligibleForFetchingData;

  final int _numberOfElementsPerRequest = 20;

  PaginationController({bool fireImmediately = true}) {
    if (fireImmediately) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    final result = await fetchPage(_pageNumberSignal.value, _numberOfElementsPerRequest);

    return result.fold(
      (error) {
        _state.value = AsyncState.error(error);
      },
      (items) {
        _isLastPageSignal.value = items.length < _numberOfElementsPerRequest;
        _pageNumberSignal.value = _pageNumberSignal.value + 1;
        if (_state.value.hasValue) {
          _state.value = AsyncState.data([..._state.value.value!, ...items]);
        } else {
          _state.value = AsyncState.data(items);
        }
      },
    );
  }

  Future<void> refresh() async {
    _state.value = AsyncState.loading();
    batch(() {
      _pageNumberSignal.value = 1;
      _isLastPageSignal.value = false;
    });
    fetchData();
  }

  Future<Either<String, List<T>>> fetchPage(int page, int limit);

  @override
  void onDispose() {
    _state.dispose();
    _pageNumberSignal.dispose();
    _isLastPageSignal.dispose();
    dispose();
  }

  void dispose() {}
}

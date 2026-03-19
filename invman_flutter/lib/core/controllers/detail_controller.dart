import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class DetailController<K, T> implements Disposable {
  final _state = asyncSignal<T>(AsyncState.loading());
  ReadonlySignal<AsyncState<T>> get state => _state;

  final K id;

  DetailController(this.id) : super() {
    _fetch();
  }

  Future<void> _fetch() async {
    _state.value = AsyncState.loading();

    final result = await retrieve(id);
    result.fold((error) => _state.value = AsyncState.error(error), (result) => _state.value = AsyncState.data(result));
  }

  Future<void> reload() => _fetch();

  Future<Either<String, T>> retrieve(K id);

  @protected
  void updateState(T newState) {
    _state.value = AsyncState.data(newState);
  }

  @override
  void onDispose() {
    _state.dispose();
  }
}

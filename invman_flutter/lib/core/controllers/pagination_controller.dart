import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class PaginationController<T> extends Disposable {
  final Signal<PagingState<int, T>> _state = signal(PagingState());
  ReadonlySignal<PagingState<int, T>> get state => _state;

  PaginationController() {
    fetchNextPage();
  }

  Future<void> fetchNextPage() async {
    final currentState = _state.value;
    if (currentState.isLoading || !currentState.hasNextPage) return;

    _state.value = currentState.copyWith(isLoading: true, error: null);

    final nextKey = (currentState.keys?.lastOrNull ?? 0) + 1;
    final result = await fetchPage(nextKey);

    result.fold(
      (error) {
        _state.value = currentState.copyWith(error: Exception(error), isLoading: false);
      },
      (items) {
        final isLastPage = items.isEmpty;
        _state.value = currentState.copyWith(
          pages: [...?currentState.pages, items],
          keys: [...?currentState.keys, nextKey],
          hasNextPage: !isLastPage,
          isLoading: false,
        );
      },
    );
  }

  Future<void> refresh() async {
    _state.value = PagingState();
    await fetchNextPage();
  }

  Future<Either<String, List<T>>> fetchPage(int page);

  @override
  void onDispose() {
    _state.dispose();
  }
}

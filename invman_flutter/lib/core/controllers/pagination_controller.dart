import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class PaginationController<T> {
  final Signal<PagingState<int, T>> state = signal(PagingState());

  PaginationController() {
    fetchNextPage();
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState.isLoading || !currentState.hasNextPage) return;

    state.value = currentState.copyWith(isLoading: true, error: null);

    final nextKey = (currentState.keys?.lastOrNull ?? 0) + 1;
    final result = await fetchPage(nextKey);

    result.fold(
      (error) {
        state.value = currentState.copyWith(
          error: Exception(error),
          isLoading: false,
        );
      },
      (items) {
        final isLastPage = items.isEmpty;
        state.value = currentState.copyWith(
          pages: [...?currentState.pages, items],
          keys: [...?currentState.keys, nextKey],
          hasNextPage: !isLastPage,
          isLoading: false,
        );
      },
    );
  }

  Future<void> refresh() async {
    state.value = PagingState();
    await fetchNextPage();
  }

  Future<Either<String, List<T>>> fetchPage(int page);
}

import 'package:fpdart/fpdart.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class PaginationController<T> extends AsyncSignal<List<T>> {
  final currentPage = signal(0);
  final hasMore = signal(true);

  PaginationController() : super(AsyncState.loading());

  Future<void> _fetch(int page) async {
    setLoading(value);

    await Future.delayed(const Duration(seconds: 1));

    final result = await getData(page);

    result.fold((error) => setError(error), (result) {
      batch(() {
        currentPage.value = page;
        final current = value.value ?? [];
        hasMore.value = result.isNotEmpty;
        setValue(current + result);
      });
    });
  }

  Future<void> checkForMore() async {
    if (value.isLoading) return;
    if (!hasMore()) return;
    await _fetch(currentPage.value + 1);
  }

  Future<Either<String, List<T>>> getData(int page);
}

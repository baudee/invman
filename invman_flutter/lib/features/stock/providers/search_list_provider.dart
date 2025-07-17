import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_list_provider.g.dart';

@riverpod
class StockSearchList extends _$StockSearchList {
  @override
  ModelState<List<Stock>> build() {
    return Success([]);
  }

  Future<void> search(String query) async {
    final result = await ref.read(stockServiceProvider).search(query: query);

    result.fold(
      (error) {
        state = Failure(error);
      },
      (stocks) {
        state = Success(stocks);
      },
    );
  }

  void clear() async {
    state = Success([]);
  }
}

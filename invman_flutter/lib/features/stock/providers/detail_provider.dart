import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@riverpod
class StockDetail extends _$StockDetail {
  @override
  ModelState<Stock> build(int id) {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final result = await ref.read(stockServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (stock) {
      state = Success(stock);
    });
  }

  Future<(bool, String?)> delete() async {
    if (state is! Success) {
      return (false, S.current.error_invalidState);
    }

    final stockToDelete = (state as Success).data;

    state = Loading();

    final result = await ref.read(stockServiceProvider).delete(id);

    return result.fold((error) {
      state = Success(stockToDelete);
      return (false, error);
    }, (deletedStock) {
      state = Success(deletedStock);
      ref.read(stockListProvider.notifier).refresh();
      return (true, S.current.core_itemDeleted);
    });
  }
}

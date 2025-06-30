import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@riverpod
class StockDetail extends _$StockDetail {
  @override
  ModelState<Stock> build(String symbol) {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final result = await ref.read(stockServiceProvider).retrieve(symbol);

    result.fold((error) {
      state = Failure(error);
    }, (stock) {
      state = Success(stock);
    });
  }
}

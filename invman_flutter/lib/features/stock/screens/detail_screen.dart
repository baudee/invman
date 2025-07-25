import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailScreen extends BaseScreen<Stock> {
  final String symbol;
  const StockDetailScreen({super.key, required this.symbol});
  static String route([String? symbol]) => "${StockRoutes.namespace}/${symbol ?? ':symbol'}";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailProvider(symbol));
    return AppBar(
      title: state is Success<Stock> ? Text(state.data.name) : null,
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailProvider(symbol));
    return BaseStateComponent(
      state: state,
      successBuilder: (stock) => StockDetailComponent(stock: stock),
      onErrorRefresh: () => ref.read(stockDetailProvider(symbol).notifier).load(),
    );
  }
}

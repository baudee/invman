import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailComponent extends ConsumerWidget {
  final String symbol;
  const StockDetailComponent({super.key, required this.symbol});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailProvider(symbol));
    final provider = ref.read(stockDetailProvider(symbol).notifier);
    return BaseStateComponent(
      state: state,
      onRefresh: () => provider.load(),
      successBuilder: (data) => Column(
        children: [
          Text(data.name),
          Divider(),
          Text(data.symbol),
          Divider(),
          Text(data.quoteType),
          Divider(),
          Text(data.value.toStringPrice(data.currency)),
        ],
      ),
    );
  }
}

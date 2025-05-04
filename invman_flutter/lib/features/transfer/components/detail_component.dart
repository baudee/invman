import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferDetailComponent extends ConsumerWidget {
  final int id;
  const TransferDetailComponent({super.key, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferDetailProvider(id));
    return BaseStateComponent(
      state: state,
      onRefresh: () => ref.read(transferDetailProvider(id).notifier).load(),
      successBuilder: (data) => Column(
        children: [
          Text(data.amount.toStringPrice(ref.read(userPreferencesProvider).currency)),
          Divider(),
          Text(data.quantity.toString()),
          Divider(),
          if (data.stock != null) StockTileComponent(stock: data.stock!),
        ],
      ),
    );
  }
}

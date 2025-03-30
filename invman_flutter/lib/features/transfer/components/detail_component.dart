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
    return switch (state) {
      Initial() || Loading() => const Center(child: CircularProgressIndicator()),
      Success() => Column(
          children: [
            Text(state.data.amount.toStringPrice(ref.read(userPreferencesProvider).currency)),
            Divider(),
            Text(state.data.quantity.toString()),
            Divider(),
            if (state.data.stock != null) StockTileComponent(stock: state.data.stock!),
          ],
        ),
      Failure() => ErrorComponent(
          error: state.error,
          handleRefresh: () => ref.read(transferDetailProvider(id).notifier).load(id),
        ),
    };
  }
}

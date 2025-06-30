import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferDetailComponent extends ConsumerWidget {
  final int id;
  const TransferDetailComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferDetailProvider(id));
    final provider = ref.read(transferDetailProvider(id).notifier);
    return BaseStateComponent(
      state: state,
      onRefresh: () => ref.read(transferDetailProvider(id).notifier).load(),
      successBuilder: (data) => Column(
        children: [
          Text(data.amount.toStringPrice(ref.read(userPreferencesProvider).currency)),
          Divider(),
          Text(data.quantity.toString()),
          Divider(),
          if (data.investment != null) InvestmentTileComponent(investment: data.investment!),
          Divider(),
          ElevatedButton.icon(
            onPressed: () async {
              final (success, message) = await provider.delete();
              ToastUtils.message(message, success: success);
              if (success) {
                context.pop();
              }
            },
            label: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailComponent extends ConsumerWidget {
  final int id;
  const StockDetailComponent({super.key, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailProvider(id));
    final provider = ref.read(stockDetailProvider(id).notifier);
    return BaseStateComponent(
      state: state,
      successBuilder: (data) => Column(
        children: [
          Text(data.name),
          Divider(),
          Text(data.symbol),
          Divider(),
          Text(data.quoteType),
          Divider(),
          Text(data.value.toStringPrice(data.currency)),
          Divider(),
          ElevatedButton.icon(
              onPressed: () async {
                final (success, message) = await provider.delete();
                if (context.mounted) {
                  ToastUtils.message(context, message, success: success);
                  if (success) {
                    context.pop();
                  }
                }
              },
              label: Icon(Icons.delete)),
        ],
      ),
    );
  }
}

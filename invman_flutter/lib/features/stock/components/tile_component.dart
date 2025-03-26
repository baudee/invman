import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/utils/toast_utils.dart';
import 'package:invman_flutter/features/stock/providers/list_provider.dart';
import 'package:invman_flutter/features/stock/providers/service_provider.dart';

class StockTileComponent extends ConsumerWidget {
  final Stock stock;
  final bool addable;

  const StockTileComponent({super.key, required this.stock, this.addable = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(stock.name),
      subtitle: addable ? Text("${stock.symbol} - ${stock.currency} - ${stock.stockExchange}") : Text(stock.symbol),
      trailing: addable ? Icon(Icons.add) : Text("${stock.value} ${stock.currency}"),
      onTap: addable
          ? () async {
              final result = await ref.read(stockServiceProvider).save(stock);
              ref.read(stockListProvider(StockListType.all).notifier).refresh();

              if (context.mounted) {
                result.fold(
                  (error) {
                    ToastUtils.message(context, error);
                  },
                  (data) {
                    ToastUtils.message(context, "Stock added successfully !");
                    context.pop();
                  },
                );
              }
            }
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockListComponent extends ConsumerWidget {
  final void Function(Stock stock)? onTileTap;
  const StockListComponent({super.key, this.onTileTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseStateComponent<List<Stock>>(
      state: ref.watch(stockSearchListProvider),
      successBuilder: (data) => ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
        itemBuilder: (context, index) {
          final stock = data[index];
          return StockTileComponent(stock: stock, onTap: onTileTap);
        },
      ),
    );
  }
}

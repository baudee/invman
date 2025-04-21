import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockListComponent extends ConsumerWidget {
  final bool useRefreshIndicator;
  final Widget? trailing;
  final Function(Stock stock)? onTap;
  const StockListComponent({super.key, this.trailing, this.onTap, this.useRefreshIndicator = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(stockListProvider.notifier);
    final pagingController = provider.pagingController;

    return InfiniteListComponent<Stock>(
      pagingController: pagingController,
      useRefreshIndicator: useRefreshIndicator,
      itemBuilder: (context, stock, index) {
        return StockTileComponent(
          stock: stock,
          trailing: trailing,
          onTap: onTap,
        );
      },
    );
  }
}

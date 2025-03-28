import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockListComponent extends ConsumerWidget {
  final StockListType type;
  final bool addable;
  final bool useRefreshIndicator;
  const StockListComponent({super.key, required this.type, this.addable = false, this.useRefreshIndicator = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(stockListProvider(type).notifier);
    final pagingController = provider.pagingController;

    return InfiniteListComponent<Stock>(
      pagingController: pagingController,
      useRefreshIndicator: useRefreshIndicator,
      handleRefresh: provider.refresh,
      noItemsFoundMessage: S.of(context).core_noItemsFound,
      itemBuilder: (context, stock, index) {
        return StockTileComponent(stock: stock, addable: addable);
      },
    );
  }
}

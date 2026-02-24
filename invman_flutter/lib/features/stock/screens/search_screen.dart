import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchScreen extends HookWidget {
  const StockSearchScreen({super.key});

  static String route() => "${StockRoutes.namespace}/search";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockSearchListController>());
    return BaseScreen(
      appBar: AppBar(
        title: StockSearchComponent(controller: controller),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(UIConstants.spacingMd),
          child: SizedBox.shrink(),
        ),
      ),
      body: InfiniteListComponent(
        refreshIndicator: false,
        controller: controller,
        itemBuilder: (stock) =>
            StockTileComponent(stock: stock, onTap: (_) => router.push(StockDetailScreen.route(stock.id))),
      ),
    );
  }
}

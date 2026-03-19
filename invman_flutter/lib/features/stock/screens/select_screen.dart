import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectScreen extends HookWidget {
  const StockSelectScreen({super.key});

  static const pathSegment = 'select';
  static String route() => '${StockRoutes.namespace}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockSearchListController>());
    return BaseScreen(
      appBar: AppBar(title: StockSearchComponent(controller: controller)),
      body: InfiniteListComponent(
        refreshIndicator: false,
        controller: controller,
        itemBuilder: (stock) => StockTileComponent(stock: stock, onTap: (_) => router.pop(stock)),
      ),
    );
  }
}

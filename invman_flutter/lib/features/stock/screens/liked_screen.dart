import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class LikedStocksScreen extends HookWidget {
  const LikedStocksScreen({super.key});

  static String route() => "${StockRoutes.namespace}/liked";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<LikedStockListController>());

    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).stock_liked)),
      body: InfiniteListComponent<Stock>(
        controller: controller,
        itemBuilder: (stock) => StockTileComponent(
          stock: stock,
          onTap: (_) => router.push(StockDetailScreen.route(stock.id)),
        ),
      ),
    );
  }
}

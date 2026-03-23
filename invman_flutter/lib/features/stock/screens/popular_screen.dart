import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class PopularStocksScreen extends HookWidget {
  final StockType type;
  const PopularStocksScreen({super.key, required this.type});

  static const pathSegment = 'popular';
  static String route() => '${StockRoutes.namespace}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<PopularStockListController>(param1: type), [type]);

    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).stock_popular)),
      body: InfiniteListComponent<Stock>(
        controller: controller,
        itemBuilder: (stock) =>
            StockTileComponent(stock: stock, onTap: (_) => router.push(StockDetailScreen.route(stock.id))),
      ),
    );
  }
}

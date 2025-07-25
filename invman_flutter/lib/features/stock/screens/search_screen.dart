import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchScreen extends BaseScreen {
  const StockSearchScreen({super.key});

  static String route() => "${StockRoutes.namespace}/search";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: StockSearchComponent(),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return SafeArea(child: StockListComponent(
      onTileTap: (stock) {
        router.push(StockDetailScreen.route(stock.symbol));
      },
    ));
  }
}

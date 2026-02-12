import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectScreen extends BaseScreen {
  const StockSelectScreen({super.key});

  static String route() => "${StockRoutes.namespace}/select";

  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(title: StockSearchComponent());
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: StockListComponent(
        onTileTap: (stock) {
          context.pop(stock);
        },
      ),
    );
  }
}

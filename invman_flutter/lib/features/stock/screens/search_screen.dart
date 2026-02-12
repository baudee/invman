import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchScreen extends BaseScreen {
  const StockSearchScreen({super.key});

  static String route() => "${StockRoutes.namespace}/search";

  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(title: StockSearchComponent());
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: StockListComponent(
        onTileTap: (stock) {
          getIt<GoRouter>().push(StockDetailScreen.route(stock.id));
        },
      ),
    );
  }
}

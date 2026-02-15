import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchScreen extends StatelessWidget {
  const StockSearchScreen({super.key});

  static String route() => "${StockRoutes.namespace}/search";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(title: StockSearchComponent()),
      body: StockListComponent(
        onTileTap: (stock) => router.push(StockDetailScreen.route(stock.id)),
      ),
    );
  }
}

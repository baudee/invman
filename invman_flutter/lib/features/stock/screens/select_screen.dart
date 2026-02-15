import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectScreen extends StatelessWidget {
  const StockSelectScreen({super.key});

  static String route() => "${StockRoutes.namespace}/select";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(title: StockSearchComponent()),
      body: StockListComponent(
        onTileTap: (stock) => context.pop(stock),
      ),
    );
  }
}

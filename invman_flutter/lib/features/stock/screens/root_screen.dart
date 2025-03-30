import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRootScreen extends StatelessWidget {
  const StockRootScreen({super.key});

  static String route() => StockRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).stock_title),
      ),
      body: StockListComponent(
        type: StockListType.all,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(StockSearchScreen.route());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectTileComponent extends StatelessWidget {
  final Stock? stock;
  final void Function(Stock) onStockSelected;
  const StockSelectTileComponent({super.key, required this.stock, required this.onStockSelected});

  @override
  Widget build(BuildContext context) {
    if (stock == null || stock!.symbol.isEmpty) {
      return ListTile(
        title: Text(S.of(context).stock_add),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final object = await context.push(StockSelectScreen.route());
          if (object is Stock) {
            onStockSelected(object);
          }
        },
      );
    } else {
      return StockTileComponent(
        trailing: Icon(Icons.arrow_forward_ios),
        stock: stock!,
        onTap: (_) async {
          final object = await context.push(StockSelectScreen.route());
          if (object is Stock) {
            onStockSelected(object);
          }
        },
      );
    }
  }
}

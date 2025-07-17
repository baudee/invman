import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectTileComponent extends ConsumerWidget {
  final int investmentId;
  final Stock? stock;
  const StockSelectTileComponent({super.key, required this.investmentId, required this.stock});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(investmentFormProvider(investmentId).notifier);
    if (stock == null || stock!.symbol.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(S.of(context).stock_add),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final object = await context.push(StockSelectScreen.route());
          if (object is Stock) {
            provider.setStock(object);
          }
        },
      );
    } else {
      return StockTileComponent(
        contentPadding: EdgeInsets.zero,
        trailing: Icon(Icons.arrow_forward_ios),
        stock: stock!,
        onTap: (_) async {
          final object = await context.push(StockSelectScreen.route());
          if (object is Stock) {
            provider.setStock(object);
          }
        },
      );
    }
  }
}

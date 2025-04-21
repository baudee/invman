import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectScreen extends ConsumerWidget {
  const StockSelectScreen({super.key});

  static String route() => "${StockRoutes.namespace}/select";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).stock_title),
      ),
      body: StockListComponent(
        useRefreshIndicator: false,
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: (stock) {
          context.pop(stock);
        },
      ),
    );
  }
}

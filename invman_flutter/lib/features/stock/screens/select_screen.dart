import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectScreen extends ConsumerWidget {
  const StockSelectScreen({super.key});

  static String route() => "${StockRoutes.namespace}/select";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: StockSearchComponent(),
      ),
      body: SafeArea(child: StockListComponent(
        onTileTap: (stock) {
          context.pop(stock);
        },
      )),
    );
  }
}

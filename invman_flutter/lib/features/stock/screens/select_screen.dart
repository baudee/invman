import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSelectScreen extends BaseScreen {
  const StockSelectScreen({super.key});

  static String route() => "${StockRoutes.namespace}/select";

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
        context.pop(stock);
      },
    ));
  }
}

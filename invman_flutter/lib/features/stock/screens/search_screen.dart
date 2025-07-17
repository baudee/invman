import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchScreen extends ConsumerWidget {
  const StockSearchScreen({super.key});

  static String route() => "${StockRoutes.namespace}/search";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: StockSearchComponent(),
      ),
      body: SafeArea(child: StockListComponent()),
    );
  }
}

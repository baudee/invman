import 'package:flutter/material.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailScreen extends StatelessWidget {
  final String symbol;
  const StockDetailScreen({super.key, required this.symbol});
  static String route([String? symbol]) => "${StockRoutes.namespace}/${symbol ?? ':symbol'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StockDetailComponent(symbol: symbol),
    );
  }
}

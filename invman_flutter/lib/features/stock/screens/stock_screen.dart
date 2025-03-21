import 'package:flutter/material.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  static String route() => StockRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock"),
      ),
      body: StockListComponent(),
    );
  }
}

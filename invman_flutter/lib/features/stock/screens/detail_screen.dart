import 'package:flutter/material.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailScreen extends StatelessWidget {
  final int id;
  const StockDetailScreen({super.key, required this.id});
  static String route([int? id]) => "${StockRoutes.namespace}/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StockDetailComponent(id: id),
    );
  }
}

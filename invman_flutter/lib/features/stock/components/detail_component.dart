import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class StockDetailComponent extends ConsumerWidget {
  final Stock stock;
  const StockDetailComponent({super.key, required this.stock});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(stock.symbol),
        Divider(),
        Text(stock.quoteType),
        Divider(),
        Text(stock.value.toStringPrice(stock.currency)),
      ],
    );
  }
}

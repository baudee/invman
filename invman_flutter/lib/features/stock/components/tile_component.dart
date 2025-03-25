import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';

class StockTileComponent extends ConsumerWidget {
  final Stock stock;
  final bool addable;

  const StockTileComponent({super.key, required this.stock, this.addable = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(stock.name),
      subtitle: Text(stock.symbol),
      trailing: addable ? Icon(Icons.add) : Text("${stock.value} ${stock.currency}"),
    );
  }
}

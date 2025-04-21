import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';

class StockTileComponent extends ConsumerWidget {
  final Stock stock;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final Function(Stock stock)? onTap;

  const StockTileComponent({super.key, required this.stock, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: contentPadding,
      title: Text(stock.name, overflow: TextOverflow.ellipsis),
      subtitle: Text("${stock.symbol} - ${stock.quoteType} - ${stock.value} ${stock.currency}"),
      trailing: trailing,
      onTap: () {
        if (onTap != null) {
          onTap!(stock);
        }
      },
    );
  }
}

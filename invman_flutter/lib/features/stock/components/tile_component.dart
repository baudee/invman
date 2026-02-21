import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockTileComponent extends StatelessWidget {
  final Stock stock;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(Stock stock)? onTap;

  const StockTileComponent({super.key, required this.stock, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      leading: AvatarComponent(stock: stock),
      title: Text(stock.name),
      subtitle: Text('${stock.symbol} - ${stock.quoteType.name} - ${stock.price.toStringPrice(stock.currency?.code)}'),
      trailing: trailing,
      onTap: onTap != null ? () => onTap!(stock) : null,
    );
  }
}

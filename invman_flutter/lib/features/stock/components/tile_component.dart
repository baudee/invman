import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
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
      subtitle: Text('${stock.symbol} - ${S.of(context).stock_type(stock.quoteType.name)}'),
      trailing: trailing,
      onTap: onTap != null ? () => onTap!(stock) : null,
    );
  }
}

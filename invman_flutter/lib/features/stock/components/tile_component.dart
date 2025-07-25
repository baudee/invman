import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class StockTileComponent extends ConsumerWidget {
  final Stock stock;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(Stock stock)? onTap;

  const StockTileComponent({super.key, required this.stock, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: contentPadding,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Text(
          stock.symbol.substring(0, stock.symbol.length > 2 ? 2 : stock.symbol.length),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      title: Text(stock.name),
      subtitle: Text('${stock.symbol} - ${stock.quoteType} - ${stock.value.toStringPrice(stock.currency)}'),
      trailing: trailing,
      onTap: onTap != null ? () => onTap!(stock) : null,
    );
  }
}

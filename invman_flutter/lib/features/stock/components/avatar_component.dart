import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';

class AvatarComponent extends StatelessWidget {
  final Stock stock;
  const AvatarComponent({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      child: Text(
        stock.symbol.substring(0, stock.symbol.length > 2 ? 2 : stock.symbol.length),
        style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}

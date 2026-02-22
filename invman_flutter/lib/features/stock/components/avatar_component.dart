import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';

class AvatarComponent extends StatelessWidget {
  final Stock stock;
  const AvatarComponent({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final noLogoText = Text(
      stock.symbol.substring(0, stock.symbol.length > 2 ? 2 : stock.symbol.length),
      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 14),
    );

    return CircleAvatar(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      child: stock.logoUrl != null
          ? Image.network(
              stock.logoUrl!,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return noLogoText;
              },
            )
          : noLogoText,
    );
  }
}

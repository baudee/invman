import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/utils/constants/constants.dart';

class AvatarComponent extends StatelessWidget {
  final Stock stock;
  final double size;
  const AvatarComponent({super.key, required this.stock, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final noLogoText = Text(
      stock.symbol.substring(0, stock.symbol.length > 2 ? 2 : stock.symbol.length),
      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: size / 3),
    );

    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.spacingSm),
          child: stock.logoUrl != null
              ? Image.network(
                  stock.logoUrl!,
                  errorBuilder: (context, error, stackTrace) {
                    return noLogoText;
                  },
                )
              : noLogoText,
        ),
      ),
    );
  }
}

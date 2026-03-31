import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';

class AvatarComponent extends StatelessWidget {
  final Asset asset;
  final double size;
  const AvatarComponent({super.key, required this.asset, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final noLogoText = Text(
      asset.symbol.substring(0, asset.symbol.length > 2 ? 2 : asset.symbol.length),
      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: size / 3),
    );

    final backgroundColor = theme.colorScheme.primary.withValues(alpha: 0.1);

    return SizedBox(
      width: size,
      height: size,
      child: asset.logoUrl != null
          ? ClipOval(
              child: Image.network(
                asset.logoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => CircleAvatar(
                  backgroundColor: backgroundColor,
                  child: noLogoText,
                ),
              ),
            )
          : CircleAvatar(
              backgroundColor: backgroundColor,
              child: noLogoText,
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class AssetHeaderComponent extends StatelessWidget {
  final Asset asset;
  const AssetHeaderComponent({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: kToolbarHeight * 2,
        left: UIConstants.spacingLg,
        right: UIConstants.spacingLg,
        bottom: UIConstants.spacingXxl * 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primaryContainer, theme.scaffoldBackgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          AvatarComponent(asset: asset, size: MediaQuery.of(context).size.width * 0.2),
          const SizedBox(width: UIConstants.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(asset.symbol, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                const SizedBox(height: UIConstants.spacingSm),
                Text(
                  asset.price.toStringPrice(asset.currency?.code),
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Text(asset.name, style: theme.textTheme.bodyMedium, overflow: .clip),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/utils/constants/ui_constants.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetCardComponent extends StatelessWidget {
  final Asset asset;
  final VoidCallback? onTap;

  const AssetCardComponent({super.key, required this.asset, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.spacingSm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarComponent(asset: asset),
              const SizedBox(height: UIConstants.spacingSm),
              Text(
                asset.symbol,
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: UIConstants.spacingXs),
              Text(
                asset.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

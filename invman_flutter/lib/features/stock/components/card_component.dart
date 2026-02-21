import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/utils/constants/ui_constants.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockCardComponent extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;

  const StockCardComponent({super.key, required this.stock, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(UIConstants.spacingMd),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(UIConstants.radiusMd),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.08),
              blurRadius: UIConstants.elevationSm,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarComponent(stock: stock),
            const SizedBox(height: UIConstants.spacingSm),
            Text(
              stock.symbol,
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: UIConstants.spacingXs),
            Text(
              stock.name,
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
    );
  }
}

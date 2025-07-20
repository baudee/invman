import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class StockDetailComponent extends ConsumerWidget {
  final Stock stock;
  const StockDetailComponent({super.key, required this.stock});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(UIConstants.spacingXxl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(UIConstants.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: UIConstants.elevationXl,
                  offset: const Offset(0, UIConstants.elevationSm * 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  stock.symbol,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: UIConstants.spacingLg),
                Text(
                  stock.value.toStringPrice(stock.currency),
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Text(
                  S.of(context).investment_currentValue,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: UIConstants.spacingXxl),
          _buildDetailCard(
            context,
            S.of(context).investment_currency,
            stock.currency,
            Icons.attach_money,
          ),
          const SizedBox(height: UIConstants.spacingMd),
          _buildDetailCard(
            context,
            S.of(context).investment_quoteType,
            stock.quoteType,
            Icons.category,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(UIConstants.spacingLg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(UIConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: UIConstants.elevationMd,
            offset: const Offset(0, UIConstants.elevationSm),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(UIConstants.spacingSm),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(UIConstants.radiusSm),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: UIConstants.iconMd,
            ),
          ),
          const SizedBox(width: UIConstants.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: UIConstants.spacingXs),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

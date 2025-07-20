import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class TransferDetailComponent extends ConsumerWidget {
  final Transfer transfer;
  const TransferDetailComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currency = ref.read(userPreferencesProvider).currency;
    final isPositive = transfer.amount > 0;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDetailCard(
            context,
            S.of(context).investment_quantity,
            transfer.amount.toStringPrice(currency),
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
          ),
          const SizedBox(height: UIConstants.spacingMd),
          _buildDetailCard(
            context,
            S.of(context).investment_quantity,
            transfer.quantity.toString(),
            Icons.numbers,
          ),
          const SizedBox(height: UIConstants.spacingMd),
          _buildDetailCard(
            context,
            S.of(context).investment_type,
            isPositive ? S.of(context).investment_deposit : S.of(context).investment_withdrawal,
            isPositive ? Icons.add_circle : Icons.remove_circle,
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

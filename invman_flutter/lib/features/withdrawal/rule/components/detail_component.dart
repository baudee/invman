import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleDetailComponent extends StatelessWidget {
  final WithdrawalRule rule;
  const WithdrawalRuleDetailComponent({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).withdrawal_currency_percentage,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: UIConstants.spacingSm),
                Text(
                  "${rule.currencyChangePercentage}%",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: UIConstants.spacingLg),
          Builder(
            builder: (_) {
              final fees = rule.fees ?? [];
              if (fees.isEmpty) {
                return Text(
                  S.of(context).core_noItemsFound,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                );
              } else {
                return Column(
                  children: fees.map(
                    (fee) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: UIConstants.spacingSm),
                        child: WithdrawalFeeTileComponent(
                          fee: fee,
                        ),
                      );
                    },
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

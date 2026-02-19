import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentHeaderComponent extends HookWidget {
  final Investment investment;

  const InvestmentHeaderComponent({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authManager = useMemoized(() => getIt<AuthManager>());

    return Container(
      margin: const EdgeInsets.only(bottom: UIConstants.spacingSm),
      padding: const EdgeInsets.all(UIConstants.spacingXxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
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
            S.of(context).investment_currentValue,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: UIConstants.spacingSm),
          Text(
            (investment.withdrawAmount ?? 0).toStringPrice(authManager.currencyCode),
            style: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w300,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: UIConstants.spacingXl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildInfoColumn(
                  context,
                  S.of(context).investment_invested,
                  (investment.investAmount).toStringPrice(authManager.currencyCode),
                ),
              ),
              Expanded(
                child: _buildInfoColumn(
                  context,
                  S.of(context).investment_return,
                  investment.percent.isNaN ? '-' : '${investment.percent.toStringAsFixed(1)}%',
                ),
              ),
              Expanded(
                child: _buildInfoColumn(
                  context,
                  S.of(context).investment_return,
                  investment.percent.isNaN ? '-' : investment.amountDifference.toStringPrice(authManager.currencyCode),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildInfoColumn(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: UIConstants.spacingXs),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/models/investment_ext.dart';

class InvestmentHeaderContent extends StatelessWidget {
  final Investment investment;
  final String currencyCode;

  const InvestmentHeaderContent({super.key, required this.investment, required this.currencyCode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [theme.colorScheme.primaryContainer, theme.scaffoldBackgroundColor],
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingLg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).investment_totalBalance.toUpperCase(), style: theme.textTheme.labelSmall),
                const SizedBox(height: UIConstants.spacingXs),
                Text(
                  investment.withdrawAmount?.toStringPrice(currencyCode) ?? "—",
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: UIConstants.spacingSm),
                _PercentBadge(percent: investment.percent, color: investment.percentColor),
                const SizedBox(height: UIConstants.spacingMd),
                _StatsRow(investment: investment, currencyCode: currencyCode),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InvestmentHeaderComponent extends SliverPersistentHeaderDelegate {
  final Investment investment;
  final String currencyCode;
  final double height;

  InvestmentHeaderComponent({required this.investment, required this.currencyCode, this.height = 260.0});

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant InvestmentHeaderComponent oldDelegate) =>
      investment != oldDelegate.investment || currencyCode != oldDelegate.currencyCode;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return InvestmentHeaderContent(investment: investment, currencyCode: currencyCode);
  }
}

class _StatsRow extends StatelessWidget {
  final Investment investment;
  final String currencyCode;

  const _StatsRow({required this.investment, required this.currencyCode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          label: S.of(context).investment_invested.toUpperCase(),
          value: investment.investAmount.toStringPrice(currencyCode),
        ),
        const SizedBox(width: UIConstants.spacingMd),
        _StatCard(
          label: S.of(context).investment_totalGain.toUpperCase(),
          value: investment.amountDifference.toStringPrice(currencyCode),
          color: investment.percentColor,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _StatCard({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.spacingMd),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: theme.textTheme.labelSmall),
                const SizedBox(height: UIConstants.spacingXs),
                Text(value, style: theme.textTheme.titleSmall?.copyWith(color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PercentBadge extends StatelessWidget {
  final double percent;
  final Color color;

  const _PercentBadge({required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    final isPositive = percent >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingMd, vertical: UIConstants.spacingSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(UIConstants.radiusXl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isPositive ? Icons.trending_up : Icons.trending_down, size: UIConstants.iconSm, color: color),
          const SizedBox(width: UIConstants.spacingXs),
          Text(
            '${isPositive ? '+' : ''}${percent.toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

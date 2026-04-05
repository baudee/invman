import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/models/investment_ext.dart';

class InvestmentHeaderContent extends StatelessWidget {
  final Investment? investment;
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
                  investment?.withdrawAmount?.toStringPrice(currencyCode) ?? "—",
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: UIConstants.spacingSm),
                PercentBadge(
                  percent: investment?.returnPercentage ?? 0,
                  color: investment?.percentColor ?? theme.colorScheme.primary,
                ),
                const SizedBox(height: UIConstants.spacingSm),
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
  final Investment? investment;
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
  final Investment? investment;
  final String currencyCode;

  const _StatsRow({required this.investment, required this.currencyCode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatCard(
          label: S.of(context).investment_invested.toUpperCase(),
          value: investment?.investAmount.toStringPrice(currencyCode) ?? "—",
        ),
        _StatCard(
          label: S.of(context).investment_unrealizedGain.toUpperCase(),
          value: investment?.unrealizedProfit.toStringPrice(currencyCode) ?? "—",
          color: _getColor(investment?.unrealizedProfit),
        ),
        _StatCard(
          label: S.of(context).investment_realizedGain.toUpperCase(),
          value: investment?.realizedProfit.toStringPrice(currencyCode) ?? "—",
          color: _getColor(investment?.realizedProfit),
        ),
      ],
    );
  }

  Color? _getColor(double? value) {
    if (value == null) return null;
    if (value > 0) return Colors.green;
    if (value < 0) return Colors.red;
    return null;
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
                Text(value, style: theme.textTheme.titleSmall?.copyWith(color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class DividendHeroCard extends StatelessWidget {
  final List<InvestmentDividend> calendar;
  final String currency;

  const DividendHeroCard({super.key, required this.calendar, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final sections = _buildSections(calendar);
    final total = sections.fold(0.0, (sum, s) => sum + s.amount);
    final year = DateTime.now().year;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(UIConstants.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).dividend_estimatedYear(year).toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(color: cs.primary),
                      ),
                      const SizedBox(height: UIConstants.spacingXs),
                      Text(
                        total.toStringPrice(currency),
                        style: theme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                if (sections.isNotEmpty)
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sections: sections.indexed.map((entry) {
                              final i = entry.$1;
                              final s = entry.$2;
                              return PieChartSectionData(
                                value: s.amount,
                                color: _color(cs, i),
                                radius: 22,
                                showTitle: false,
                              );
                            }).toList(),
                            centerSpaceRadius: 32,
                            sectionsSpace: 2,
                            startDegreeOffset: -90,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${sections.length}',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              S.of(context).asset(sections.length),
                              style: theme.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (sections.isNotEmpty) ...[
              const SizedBox(height: UIConstants.spacingMd),
              const Divider(height: 1),
              const SizedBox(height: UIConstants.spacingMd),
              ...sections.indexed.map((entry) {
                final i = entry.$1;
                final s = entry.$2;
                return Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _color(cs, i),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: UIConstants.spacingSm),
                    Expanded(
                      child: Text(
                        s.name,
                        style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      s.amount.toStringPrice(currency),
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  static Color _color(ColorScheme cs, int index) {
    final colors = [
      cs.primary,
      cs.secondary,
      cs.tertiary,
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
      cs.outline,
    ];
    return colors[index % colors.length];
  }

  static List<_Section> _buildSections(List<InvestmentDividend> items) {
    return items
        .map((inv) {
          final total = inv.dividends.fold(0.0, (sum, d) => sum + d.amount);
          return _Section(name: inv.investment.name, amount: total);
        })
        .where((s) => s.amount > 0)
        .toList();
  }
}

class _Section {
  final String name;
  final double amount;
  const _Section({required this.name, required this.amount});
}

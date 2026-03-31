import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class DividendHistoryChart extends StatelessWidget {
  final List<TotalDividendYear> history;
  final String currency;

  const DividendHistoryChart({super.key, required this.history, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (history.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(UIConstants.spacingLg),
        child: Center(
          child: Text(S.of(context).dividend_noData, style: theme.textTheme.bodyMedium),
        ),
      );
    }

    final sorted = [...history]..sort((a, b) => a.year.compareTo(b.year));
    final total = sorted.fold(0.0, (sum, y) => sum + y.total);
    final maxY = sorted.map((y) => y.total).reduce((a, b) => a > b ? a : b);
    final firstYear = sorted.first.year;
    final lastYear = sorted.last.year;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(UIConstants.spacingLg),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: UIConstants.spacingXs),
                      Text(
                        total.toStringPrice(currency),
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: UIConstants.spacingXs),
                      Text(
                        S.of(context).dividend_totalReceived(firstYear, lastYear),
                        style: theme.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: UIConstants.spacingLg),
            SizedBox(
              height: 140,
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  minY: 0,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= sorted.length) return const SizedBox.shrink();
                          final amount = sorted[index].total;
                          final progress = sorted.length > 1 ? index / (sorted.length - 1) : 1.0;
                          final color = Color.lerp(
                            cs.primary.withValues(alpha: 0.5),
                            cs.primary,
                            progress,
                          )!;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              amount >= 1000 ? '${(amount / 1000).toStringAsFixed(1)}k' : amount.toStringAsFixed(1),
                              style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= sorted.length) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              '${sorted[index].year}',
                              style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: sorted.indexed.map((entry) {
                    final i = entry.$1;
                    final year = entry.$2;
                    final progress = sorted.length > 1 ? i / (sorted.length - 1) : 1.0;
                    final color = Color.lerp(
                      cs.primary.withValues(alpha: 0.3),
                      cs.primary,
                      progress,
                    )!;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: year.total,
                          color: color,
                          width: 28,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

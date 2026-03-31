import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class DividendMonthlyChart extends StatelessWidget {
  final List<ComputedDividendValue> calendar;
  final String currency;

  const DividendMonthlyChart({super.key, required this.calendar, required this.currency});

  static String _compact(double amount) {
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}k';
    return amount.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();

    final monthly = _buildMonthlyTotals(calendar);
    final maxY = monthly.values.isEmpty ? 1.0 : monthly.values.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(UIConstants.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
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
                          if (index < 0 || index > 11) return const SizedBox.shrink();
                          final month = index + 1;
                          final amount = monthly[month] ?? 0.0;
                          if (amount <= 0) return const SizedBox.shrink();
                          final isUpcoming = month > now.month;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              _compact(amount),
                              style: TextStyle(
                                fontSize: 9,
                                color: isUpcoming ? cs.onSurfaceVariant : cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
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
                          if (index < 0 || index > 11) return const SizedBox.shrink();
                          final month = index + 1;
                          final isCurrentMonth = month == now.month;
                          final label = DateFormat.MMM(locale).format(DateTime(now.year, month));
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              label,
                              style: TextStyle(
                                fontSize: 9,
                                color: isCurrentMonth ? cs.primary : cs.onSurfaceVariant,
                                fontWeight: isCurrentMonth ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(12, (i) {
                    final month = i + 1;
                    final amount = monthly[month] ?? 0.0;
                    final isUpcoming = month > now.month;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: amount > 0 ? amount : maxY * 0.02,
                          color: amount > 0
                              ? (isUpcoming ? cs.surfaceContainerHighest : cs.primary)
                              : cs.surfaceContainerHighest.withValues(alpha: 0.3),
                          width: 16,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                          borderSide: BorderSide.none,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: UIConstants.spacingSm),
            Row(
              children: [
                _LegendItem(color: cs.primary, label: S.of(context).dividend_received),
                const SizedBox(width: UIConstants.spacingLg),
                _LegendItem(
                  color: cs.surfaceContainerHighest,
                  label: S.of(context).dividend_upcoming,
                  outlined: true,
                  outlineColor: cs.outline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Map<int, double> _buildMonthlyTotals(List<ComputedDividendValue> items) {
    final result = <int, double>{};
    for (final entry in items) {
      result[entry.date.month] = (result[entry.date.month] ?? 0) + entry.amount;
    }
    return result;
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool outlined;
  final Color? outlineColor;

  const _LegendItem({required this.color, required this.label, this.outlined = false, this.outlineColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
            border: outlined ? Border.all(color: outlineColor ?? color, width: 1) : null,
          ),
        ),
        const SizedBox(width: UIConstants.spacingXs),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

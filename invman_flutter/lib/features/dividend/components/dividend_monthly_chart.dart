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

    final totals = _buildMonthlyTotals(calendar, now);
    final monthlyTotals = List.generate(12, (i) {
      final month = i + 1;
      return (totals.received[month] ?? 0.0) + (totals.partialUpcoming[month] ?? 0.0);
    });
    final maxY = monthlyTotals.isEmpty ? 1.0 : monthlyTotals.reduce((a, b) => a > b ? a : b);

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
                          final isUpcoming = month > now.month;
                          final received = totals.received[month] ?? 0.0;
                          final partial = totals.partialUpcoming[month] ?? 0.0;
                          // For current month: label shows received amount (confirmed payments only)
                          final labelAmount = received > 0 ? received : partial;
                          if (labelAmount <= 0) return const SizedBox.shrink();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              _compact(labelAmount),
                              style: TextStyle(
                                fontSize: 9,
                                color: isUpcoming || received <= 0 ? cs.onSurfaceVariant : cs.primary,
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
                    final isUpcoming = month > now.month;
                    final isCurrentMonth = month == now.month;
                    final received = totals.received[month] ?? 0.0;
                    final partial = totals.partialUpcoming[month] ?? 0.0;
                    final total = received + partial;

                    if (isCurrentMonth && total > 0) {
                      // Stacked bar: received (bottom, primary) + partial upcoming (top, grey)
                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: total,
                            width: 16,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            borderSide: BorderSide.none,
                            rodStackItems: [
                              BarChartRodStackItem(0, received, cs.primary),
                              if (partial > 0) BarChartRodStackItem(received, total, cs.surfaceContainerHighest),
                            ],
                          ),
                        ],
                      );
                    }

                    final amount = received;
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

  static ({Map<int, double> received, Map<int, double> partialUpcoming}) _buildMonthlyTotals(
    List<ComputedDividendValue> items,
    DateTime now,
  ) {
    final received = <int, double>{};
    final partialUpcoming = <int, double>{};

    for (final entry in items) {
      final month = entry.date.month;
      if (month == now.month) {
        // Within current month: split by whether payment date has passed
        if (!entry.date.isAfter(now)) {
          received[month] = (received[month] ?? 0) + entry.amount;
        } else {
          partialUpcoming[month] = (partialUpcoming[month] ?? 0) + entry.amount;
        }
      } else {
        received[month] = (received[month] ?? 0) + entry.amount;
      }
    }

    return (received: received, partialUpcoming: partialUpcoming);
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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InvestmentReturnsGraphComponent extends StatefulWidget {
  final InvestmentDetailController controller;
  final UserPreferencesManager preferencesManager;

  const InvestmentReturnsGraphComponent({
    super.key,
    required this.controller,
    required this.preferencesManager,
  });

  @override
  State<InvestmentReturnsGraphComponent> createState() => _InvestmentReturnsGraphComponentState();
}

class _InvestmentReturnsGraphComponentState extends State<InvestmentReturnsGraphComponent>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: InvestmentReturnInterval.values.length,
      vsync: this,
      initialIndex: widget.preferencesManager.investmentReturnInterval.value.index,
    );
    _tabController.addListener(() {
      widget.preferencesManager.setInvestmentReturnInterval(
        InvestmentReturnInterval.values[_tabController.index],
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: InvestmentReturnInterval.values
              .map((e) => Tab(text: S.of(context).investment_return_interval(e.name)))
              .toList(),
        ),
        const SizedBox(height: UIConstants.spacingSm),
        SizedBox(
          height: 220,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: InvestmentReturnInterval.values
                .map(
                  (interval) => Builder(
                    builder: (context) {
                      final raw = widget.controller.getReturnsFromInterval(interval).watch(context);
                      if (raw.isEmpty) {
                        return Center(child: Text(S.of(context).investment_add_transfers));
                      }
                      final returns = [...raw]
                        ..sort((a, b) {
                          final y = a.year.compareTo(b.year);
                          return y != 0 ? y : a.month.compareTo(b.month);
                        });
                      return BarChart(_getBarChartData(context, returns, interval));
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  BarChartData _getBarChartData(
    BuildContext context,
    List<InvestmentReturn> returns,
    InvestmentReturnInterval interval,
  ) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    return BarChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        checkToShowHorizontalLine: (value) => value == 0,
        getDrawingHorizontalLine: (_) => FlLine(color: theme.colorScheme.primary, strokeWidth: 1),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 44,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= returns.length) return const SizedBox.shrink();
              final r = returns[index];
              final color = r.percentage > 0 ? Colors.green : (r.percentage < 0 ? Colors.red : Colors.grey);
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${r.percentage.toStringAsFixed(1)}%',
                      style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      r.gains.toStringAsFixed(1),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= returns.length) return const SizedBox.shrink();
              final r = returns[index];
              final label = interval == InvestmentReturnInterval.yearly
                  ? '${r.year}'
                  : _monthLabel(r.month, r.year, locale);
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(label, style: const TextStyle(fontSize: 10)),
              );
            },
          ),
        ),
      ),
      barTouchData: BarTouchData(enabled: false),
      barGroups: returns.indexed.map((entry) {
        final index = entry.$1;
        final r = entry.$2;
        final color = r.percentage > 0 ? Colors.green : (r.percentage < 0 ? Colors.red : Colors.grey);
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: r.percentage,
              color: color.withValues(alpha: 0.75),
              width: 10,
              borderRadius: r.percentage >= 0
                  ? const BorderRadius.vertical(top: Radius.circular(3))
                  : const BorderRadius.vertical(bottom: Radius.circular(3)),
            ),
          ],
        );
      }).toList(),
    );
  }

  static String _monthLabel(int month, int year, String locale) {
    final abbr = DateFormat.MMM(locale).format(DateTime(year, month));
    final y = year.toString().substring(2);
    return "$abbr '$y";
  }
}

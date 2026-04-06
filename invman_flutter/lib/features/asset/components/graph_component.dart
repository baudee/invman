import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/asset.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AssetGraphComponent extends StatefulWidget {
  final UserPreferencesManager preferencesManager;
  final AssetDetailController controller;
  const AssetGraphComponent({super.key, required this.preferencesManager, required this.controller});

  @override
  State<AssetGraphComponent> createState() => _AssetGraphComponentState();
}

class _AssetGraphComponentState extends State<AssetGraphComponent> with TickerProviderStateMixin {
  late final TabController _tabController;
  final Signal<AssetValue?> _touchedPoint = signal(null);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AssetTimeHorizon.values.length,
      vsync: this,
      initialIndex: widget.preferencesManager.assetTimeHorizon.value.index,
    );
    widget.preferencesManager.setAssetTimeHorizon(AssetTimeHorizon.values[_tabController.index]);
    _tabController.addListener(() {
      _touchedPoint.value = null;
      widget.preferencesManager.setAssetTimeHorizon(AssetTimeHorizon.values[_tabController.index]);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _touchedPoint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: AssetTimeHorizon.values.map((e) => Tab(text: S.of(context).asset_time_horizon(e.name))).toList(),
        ),
        const SizedBox(height: UIConstants.spacingSm),
        SizedBox(
          height: 250,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: AssetTimeHorizon.values
                .map(
                  (horizon) => Builder(
                    builder: (context) {
                      return BaseStateComponent(
                        state: widget.controller.getTimeseriesFromTimeHorizon(horizon),
                        successBuilder: (data) {
                          if (data.isEmpty) {
                            return Center(child: Text(S.of(context).asset_no_data));
                          }
                          return Column(
                            children: [
                              Expanded(child: LineChart(_getLineChartData(data))),
                              const SizedBox(height: UIConstants.spacingSm),
                              _InfoPanel(
                                touchedPoint: _touchedPoint,
                                timeHorizon: horizon,
                                currencyCode: widget.controller.state.value.requireValue.currency?.code ?? '',
                                timeSeries: data,
                              ),
                            ],
                          );
                        },
                        onReload: () => widget.controller.reloadTimeseries(horizon),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  LineChartData _getLineChartData(List<AssetValue> timeSeries) {
    final theme = Theme.of(context);
    List<Color> gradientColors = [theme.colorScheme.primary, theme.scaffoldBackgroundColor];
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: const LineTouchTooltipData(getTooltipItems: _noTooltipItems),
        touchCallback: (event, response) {
          if (!event.isInterestedForInteractions || response?.lineBarSpots == null || response!.lineBarSpots!.isEmpty) {
            _touchedPoint.value = null;
            return;
          }
          final spot = response.lineBarSpots!.first;
          _touchedPoint.value = timeSeries.reversed.elementAt(spot.x.toInt());
        },
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(color: theme.colorScheme.primary, strokeWidth: 1),
              FlDotData(
                getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                  radius: 3,
                  color: theme.colorScheme.primary,
                  strokeWidth: 1,
                  strokeColor: theme.colorScheme.surface,
                ),
              ),
            );
          }).toList();
        },
      ),
      lineBarsData: [
        LineChartBarData(
          spots: timeSeries.reversed.indexed.map((e) => FlSpot(e.$1.toDouble(), e.$2.value)).toList(),
          isCurved: true,
          curveSmoothness: 0.1,
          color: theme.colorScheme.primary,
          barWidth: 2,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors.map((color) => color.withValues(alpha: 0.4)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  static List<LineTooltipItem?> _noTooltipItems(List<LineBarSpot> spots) => spots.map((_) => null).toList();
}

class _InfoPanel extends StatelessWidget {
  final AssetTimeHorizon timeHorizon;
  final Signal<AssetValue?> touchedPoint;
  final String currencyCode;
  final List<AssetValue> timeSeries;

  const _InfoPanel({
    required this.timeHorizon,
    required this.touchedPoint,
    required this.currencyCode,
    required this.timeSeries,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final point = touchedPoint.watch(context);

    final percent = timeSeries.length >= 2 && timeSeries.last.value != 0
        ? (timeSeries.first.value - timeSeries.last.value) / timeSeries.last.value * 100
        : 0.0;
    final percentColor = percent > 0 ? Colors.green : (percent < 0 ? Colors.red : Colors.grey);

    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          PercentBadge(percent: percent, color: percentColor),
          point == null
              ? Text(
                  S.of(context).asset_see_details_graph,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      point.value.toStringPrice(currencyCode),
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: UIConstants.spacingMd),
                    Text(
                      _formatDate(point.timestamp.toLocal(), timeHorizon),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt, AssetTimeHorizon timeHorizon) {
    final date = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    if (timeHorizon == AssetTimeHorizon.oneDay || timeHorizon == AssetTimeHorizon.oneWeek) {
      final time = '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      return '$date $time';
    } else {
      return date;
    }
  }
}

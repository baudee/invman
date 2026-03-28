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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: AssetTimeHorizon.values.length, vsync: this);
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
          tabs: AssetTimeHorizon.values.map((e) => Tab(text: S.of(context).asset_time_horizon(e.name))).toList(),
        ),
        const SizedBox(height: UIConstants.spacingSm),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: AssetTimeHorizon.values
                .map(
                  (e) => Builder(
                    builder: (context) {
                      widget.preferencesManager.setAssetTimeHorizon(e);
                      final timeSeries = widget.controller.getTimeseriesFromTimeHorizon(e);
                      return LineChart(_getLineChartData(timeSeries.watch(context)));
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _rightTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text = switch (value.toInt()) {
      1 => '10K',
      3 => '30k',
      5 => '50k',
      _ => '',
    };

    return Text(text, style: style, textAlign: TextAlign.left);
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
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: _rightTitleWidget,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: timeSeries.map((e) => FlSpot(e.timestamp.millisecondsSinceEpoch.toDouble(), e.value)).toList(),
          isCurved: false,
          color: theme.colorScheme.primary,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: gradientColors.map((color) => color.withValues(alpha: 0.4)).toList(),
            ),
          ),
        ),
      ],
      
    );
  }
}

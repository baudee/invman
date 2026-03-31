import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/dividend/components/dividend_hero_card.dart';
import 'package:invman_flutter/features/dividend/components/dividend_history_chart.dart';
import 'package:invman_flutter/features/dividend/components/dividend_monthly_chart.dart';
import 'package:invman_flutter/features/dividend/components/dividend_next_payments.dart';

class DividendRootComponent extends StatelessWidget {
  final List<ComputedDividendValue> calendar;
  final List<TotalDividendYear> history;
  final String selectedCurrency;
  final void Function(String) onSelectCurrency;

  const DividendRootComponent({
    super.key,
    required this.calendar,
    required this.history,
    required this.selectedCurrency,
    required this.onSelectCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedCurrency.isNotEmpty) ...[
          DividendHeroCard(calendar: calendar, currency: selectedCurrency),
          const SizedBox(height: UIConstants.spacingSm),
          SectionHeaderComponent(title: S.of(context).dividend_calendar),
          DividendMonthlyChart(calendar: calendar, currency: selectedCurrency),
          const SizedBox(height: UIConstants.spacingSm),
          SectionHeaderComponent(title: S.of(context).dividend_nextPayments),
          DividendNextPayments(calendar: calendar),
          const SizedBox(height: UIConstants.spacingSm),
          SectionHeaderComponent(title: S.of(context).dividend_history),
          DividendHistoryChart(history: history, currency: selectedCurrency),
          const SizedBox(height: UIConstants.spacingSm),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/dividend/components/components.dart';

class DividendNextPayments extends StatelessWidget {
  final List<InvestmentDividend> calendar;

  const DividendNextPayments({super.key, required this.calendar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();

    final upcoming =
        calendar
            .expand((inv) => inv.dividends.map((d) => _PaymentEntry(investment: inv.investment, dividend: d)))
            .where((e) => e.dividend.date.isAfter(now))
            .toList()
          ..sort((a, b) => a.dividend.date.compareTo(b.dividend.date));

    final next3 = upcoming.take(3).toList();

    if (next3.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: UIConstants.spacingLg),
        child: Center(
          child: Text(S.of(context).dividend_noData, style: theme.textTheme.bodyMedium),
        ),
      );
    }

    return Column(
      spacing: UIConstants.spacingXs,
      children: next3.map((e) => DividendListTile(entry: e.dividend, investment: e.investment)).toList(),
    );
  }
}

class _PaymentEntry {
  final Investment investment;
  final ComputedDividendValue dividend;

  const _PaymentEntry({required this.investment, required this.dividend});
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/dividend/dividend.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DividendRootScreen extends HookWidget {
  const DividendRootScreen({super.key});

  static const pathSegment = '/dividends';
  static String route() => pathSegment;

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<DividendController>());

    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).dividend_title)),
      body: BaseStateComponent(
        state: controller.state,
        successBuilder: (data) {
          final currencies = data.calendar.map((inv) => inv.investment.asset?.currency?.code ?? '?').toSet().toList()
            ..sort();
          final filteredCalendar = controller.selectedCurrency.value.isEmpty
              ? <InvestmentDividend>[]
              : data.calendar
                    .where((inv) => inv.investment.asset?.currency?.code == controller.selectedCurrency.value)
                    .toList();
          final filteredHistory = data.history.where((h) => h.currency == controller.selectedCurrency.value).toList();
          final hasData = data.calendar.isNotEmpty || data.history.isNotEmpty;
          return hasData
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      if (currencies.length > 1) ...[
                        CurrencyChips(
                          currencies: currencies,
                          selected: controller.selectedCurrency.value.isEmpty
                              ? null
                              : controller.selectedCurrency.value,
                          onSelect: (currency) => controller.setSelectedCurrency(currency),
                        ),
                        const SizedBox(height: UIConstants.spacingSm),
                      ],
                      DividendRootComponent(
                        calendar: filteredCalendar,
                        history: filteredHistory,
                        selectedCurrency: controller.selectedCurrency.watch(context),
                        onSelectCurrency: controller.setSelectedCurrency,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(UIConstants.spacingLg),
                  child: Center(
                    child: Text(
                      S.of(context).dividend_noData_actionCall,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
        },
        onReload: controller.reload,
      ),
    );
  }
}

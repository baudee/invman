import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/asset/components/tile_component.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentDetailComponent extends StatelessWidget {
  final InvestmentDetailController controller;
  final AuthManager authManager;
  final UserPreferencesManager preferencesManager;
  const InvestmentDetailComponent({
    super.key,
    required this.controller,
    required this.authManager,
    required this.preferencesManager,
  });

  static const double headerHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    final investment = controller.state.value.requireValue;
    return RefreshIndicator(
      onRefresh: controller.reload,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        child: Material(
          child: Column(
            children: [
              InvestmentHeaderContent(investment: investment, currencyCode: authManager.currencyCode),
              Padding(
                padding: .symmetric(horizontal: UIConstants.appHorizontalPadding),
                child: Column(
                  spacing: UIConstants.spacingXs,
                  children: [
                    InvestmentReturnsGraphComponent(controller: controller, preferencesManager: preferencesManager),
                    const SizedBox(height: UIConstants.spacingMd),
                    ElevatedButton(
                      onPressed: () async {
                        await router.push(TransferRootScreen.route(investment.id!));
                        controller.reload();
                      },
                      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 0)),
                      child: Text(S.of(context).transfer_title),
                    ),
                    if (investment.asset != null) ...[
                      const SizedBox(height: UIConstants.spacingSm),
                      SectionHeaderComponent(title: S.of(context).asset(1)),
                      AssetTileComponent(asset: investment.asset!),
                      ListTile(
                        leading: Icon(Icons.confirmation_number, color: Theme.of(context).colorScheme.primary),
                        title: Text(S.of(context).investment_quantity),
                        trailing: Text(investment.quantity.toString()),
                      ),
                      ListTile(
                        leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                        title: Text("${S.of(context).asset(1)} ${S.of(context).core_lastUpdate}"),
                        trailing: Text(
                          investment.asset?.timestamp != null
                              ? DateFormat.yMMMd().add_jm().format(investment.asset!.timestamp!.toLocal())
                              : '-',
                        ),
                      ),
                      if (investment.forex != null)
                        ListTile(
                          leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                          title: Text("${S.of(context).account_currency} ${S.of(context).core_lastUpdate}"),
                          subtitle: Text(investment.forex!.toStringComparison()),
                          trailing: Text(DateFormat.yMMMd().add_jm().format(investment.forex!.timestamp.toLocal())),
                        ),
                    ],
                    if (investment.withdrawalRule != null) ...[
                      SizedBox(height: UIConstants.spacingMd),
                      SectionHeaderComponent(title: S.of(context).withdrawal),
                      WithdrawalRuleTileComponent(rule: investment.withdrawalRule!),
                    ],
                    const SizedBox(height: UIConstants.spacingXs),
                    SectionHeaderComponent(title: S.of(context).investment_title),
                    ListTile(
                      leading: Icon(Icons.confirmation_number, color: Theme.of(context).colorScheme.primary),
                      title: Text("${S.of(context).core_id}:"),
                      trailing: Text(investment.id.toString()),
                    ),
                    const SizedBox(height: UIConstants.spacingMd),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

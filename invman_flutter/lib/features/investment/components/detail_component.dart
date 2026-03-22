import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/components/tile_component.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentDetailComponent extends StatelessWidget {
  final InvestmentDetailController controller;
  final AuthManager authManager;
  const InvestmentDetailComponent({
    super.key,
    required this.controller,
    required this.authManager,
  });

  static const double headerHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    final investment = controller.state.value.requireValue;
    return SingleChildScrollView(
      child: Material(
        child: Column(
          children: [
            InvestmentHeaderContent(investment: investment, currencyCode: authManager.currencyCode),
            Padding(
              padding: .symmetric(horizontal: UIConstants.appHorizontalPadding),
              child: Column(
                spacing: UIConstants.spacingXs,
                children: [
                  const SizedBox(height: UIConstants.spacingSm),
                  if (investment.stock != null) ...[
                    SectionHeaderComponent(title: S.of(context).stock),
                    StockTileComponent(stock: investment.stock!),
                    ListTile(
                      leading: Icon(Icons.confirmation_number, color: Theme.of(context).colorScheme.primary),
                      title: Text(S.of(context).investment_quantity),
                      trailing: Text(investment.quantity.toString()),
                    ),
                    ListTile(
                      leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                      title: Text("${S.of(context).stock} ${S.of(context).core_lastUpdate}"),
                      trailing: Text(DateFormat.yMMMd().add_jm().format(investment.stock!.timestamp.toLocal())),
                    ),
                    ListTile(
                      leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                      title: Text("${S.of(context).account_currency} ${S.of(context).core_lastUpdate}"),
                      trailing: authManager.currency != null
                          ? Text(DateFormat.yMMMd().add_jm().format(authManager.currency!.timestamp.toLocal()))
                          : null,
                    ),
                  ],
                  if (investment.withdrawalRule != null) ...[
                    SizedBox(height: UIConstants.spacingMd),
                    SectionHeaderComponent(title: S.of(context).withdrawal),
                    WithdrawalRuleTileComponent(rule: investment.withdrawalRule!),
                  ],
                  const SizedBox(height: UIConstants.spacingLg),
                  ElevatedButton(
                    onPressed: () async {
                      await router.push(TransferRootScreen.route(investment.id!));
                      controller.reload();
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 0)),
                    child: Text(S.of(context).transfer_title),
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

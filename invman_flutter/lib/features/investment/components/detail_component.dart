import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/components/tile_component.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentDetailComponent extends StatelessWidget {
  final Investment investment;
  final InvestmentDetailController controller;
  final AuthManager authManager;
  const InvestmentDetailComponent({
    super.key,
    required this.investment,
    required this.controller,
    required this.authManager,
  });

  static const double headerHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: InvestmentHeaderComponent(
                height: headerHeight,
                investment: investment,
                currencyCode: authManager.currencyCode,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: UIConstants.appHorizontalPadding),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: UIConstants.spacingSm),
                    if (investment.stock != null)
                      Column(
                        spacing: UIConstants.spacingSm,
                        children: [
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
                            trailing: Text(DateFormat.yMMMd().add_jm().format(investment.stock!.updatedAt.toLocal())),
                          ),
                          ListTile(
                            leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                            title: Text("${S.of(context).account_currency} ${S.of(context).core_lastUpdate}"),
                            trailing: authManager.currency != null
                                ? Text(DateFormat.yMMMd().add_jm().format(authManager.currency!.updatedAt.toLocal()))
                                : null,
                          ),
                        ],
                      ),
                    if (investment.withdrawalRule != null)
                      Column(
                        spacing: UIConstants.spacingSm,
                        children: [
                          SizedBox(height: UIConstants.spacingMd),
                          SectionHeaderComponent(title: S.of(context).withdrawal),
                          WithdrawalRuleTileComponent(rule: investment.withdrawalRule!),
                        ],
                      ),
                    const SizedBox(height: UIConstants.spacingLg),
                    ElevatedButton(
                      onPressed: () async {
                        await router.pushRelative(TransferRootScreen.route());
                        controller.reload();
                      },
                      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 0)),
                      child: Text(S.of(context).transfer_title),
                    ),
                    const SizedBox(height: UIConstants.spacingMd),
                  ],
                ),
              ),
            ),
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingXs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                PopupMenuActions(
                  onEdit: () async {
                    await router.pushRelative(InvestmentEditScreen.route());
                    controller.reload();
                  },
                  onDelete: () async {
                    final (success, message) = await controller.delete();
                    router.pop();
                    ToastUtils.message(message, success: success);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

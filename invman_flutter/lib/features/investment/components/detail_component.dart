import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/components/tile_component.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentDetailComponent extends StatelessWidget {
  final Investment investment;
  const InvestmentDetailComponent({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InvestmentHeaderComponent(investment: investment),
          Divider(),
          Text(S.of(context).investment_quantity, style: Theme.of(context).textTheme.titleSmall),
          Text(investment.quantity.toString(), style: Theme.of(context).textTheme.bodyMedium),
          Divider(),
          if (investment.withdrawalRule != null) WithdrawalRuleTileComponent(rule: investment.withdrawalRule!),
          Divider(),
          if (investment.stock != null)
            Column(
              children: [
                StockTileComponent(stock: investment.stock!),
                Divider(),
              ],
            ),
          ElevatedButton(
            onPressed: () {
              router.pushRelative(TransferRootScreen.route());
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 0)),
            child: Text(S.of(context).transfer_title),
          ),
        ],
      ),
    );
  }
}

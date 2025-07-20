import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/components/tile_component.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/rule/rule.dart';

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
          if (investment.withdrawalRule != null)
            WithdrawalRuleTileComponent(
              rule: investment.withdrawalRule!,
              onTap: (_) {},
            ),
          Divider(),
          if (investment.stock != null) StockTileComponent(stock: investment.stock!),
          Divider(),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: investment.transfers?.length ?? 0,
            itemBuilder: (context, index) {
              final transfers = investment.transfers ?? [];
              return TransferTileComponent(transfer: transfers[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: UIConstants.spacingXs),
          ),
        ],
      ),
    );
  }
}

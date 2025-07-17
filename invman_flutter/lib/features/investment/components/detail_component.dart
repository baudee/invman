import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/components/tile_component.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/rule/rule.dart';

class InvestmentDetailComponent extends ConsumerWidget {
  final int id;
  const InvestmentDetailComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(investmentDetailProvider(id));
    return BaseStateComponent(
      state: state,
      onErrorRefresh: () => ref.read(investmentDetailProvider(id).notifier).load(),
      successBuilder: (data) => SingleChildScrollView(
        child: Column(
          children: [
            InvestmentHeaderComponent(investment: data),
            Divider(),
            if (data.withdrawalRule != null)
              WithdrawalRuleTileComponent(
                rule: data.withdrawalRule!,
                onTap: (_) {},
              ),
            Divider(),
            if (data.stock != null) StockTileComponent(stock: data.stock!),
            Divider(),
            Builder(
              builder: (context) {
                final List<TransferTileComponent> tiles = [];
                final transfers = data.transfers ?? [];
                for (final transfer in transfers) {
                  tiles.add(
                    TransferTileComponent(
                      transfer: transfer,
                    ),
                  );
                }
                return Column(
                  children: tiles,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentListComponent extends ConsumerWidget {
  const InvestmentListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(investmentListProvider);

    onRefresh() async {
      ref.read(investmentListProvider.notifier).load();
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: BaseStateComponent(
        state: state,
        onErrorRefresh: onRefresh,
        successBuilder: (data) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Builder(
            builder: (context) {
              final totalInvestment = Investment(
                userId: UuidValue.fromString(Namespace.nil.value),
                name: 'TOTAL',
                stockId: 0,
                withdrawalRuleId: 0,
                investAmount: data.fold(0.0, (sum, item) => sum! + item.investAmount),
                withdrawAmount: data.fold(0.0, (sum, item) => sum! + (item.withdrawAmount ?? 0.0)),
              );
              return Column(
                children: [
                  InvestmentHeaderComponent(investment: totalInvestment),
                  ...data.map((investment) => InvestmentTileComponent(investment: investment)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

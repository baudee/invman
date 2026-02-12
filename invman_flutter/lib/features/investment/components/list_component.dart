import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentListComponent extends StatelessWidget {
  const InvestmentListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<InvestmentListController>();

    return RefreshIndicator(
      onRefresh: () async => controller.refresh(),
      child: BaseStateComponent<List<Investment>>(
        state: controller,
        successBuilder: (data) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Builder(
            builder: (context) {
              final totalInvestment = Investment(
                userId: UuidValue.fromString(Namespace.nil.value),
                name: 'TOTAL',
                stockId: UuidValue.fromString(Namespace.nil.value),
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

import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InvestmentRootComponent extends StatelessWidget {
  final InvestmentListController controller;
  final String currencyCode;

  const InvestmentRootComponent({
    super.key,
    required this.controller,
    required this.currencyCode,
  });

  static const double headerHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.loadTotal().then((_) => controller.refresh());
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: headerHeight,
              child: InvestmentHeaderContent(
                investment: controller.total.watch(context),
                currencyCode: currencyCode,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: UIConstants.spacingXs,
              horizontal: UIConstants.appHorizontalPadding,
            ),
            sliver: InfiniteSliverListComponent(
              controller: controller,
              itemBuilder: (investment) => InvestmentTileComponent(investment: investment),
            ),
          ),
        ],
      ),
    );
  }
}

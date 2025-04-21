import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentListComponent extends ConsumerWidget {
  const InvestmentListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(investmentListProvider.notifier);
    final pagingController = provider.pagingController;

    return SliverInfiniteListComponent<Investment>(
      pagingController: pagingController,
      useRefreshIndicator: false,
      itemBuilder: (context, investment, index) {
        return InvestmentTileComponent(investment: investment);
      },
      header: InvestmentHeaderComponent(),
    );
  }
}

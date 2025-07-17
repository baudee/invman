import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentSliverListComponent extends ConsumerWidget {
  const InvestmentSliverListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(investmentListProvider.notifier);
    final pagingController = provider.pagingController;

    final state = ref.watch(investmentTotalProvider);
    return BaseStateComponent(
      state: state,
      onErrorRefresh: () async {
        pagingController.refresh();
        ref.read(investmentTotalProvider.notifier).load();
      },
      successBuilder: (data) => SliverInfiniteListComponent<Investment>(
        pagingController: pagingController,
        itemBuilder: (context, investment, index) {
          return InvestmentTileComponent(investment: investment);
        },
        header: InvestmentSliverHeaderComponent(invesment: data),
      ),
    );
  }
}

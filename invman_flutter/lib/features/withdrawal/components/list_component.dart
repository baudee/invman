import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalListComponent extends ConsumerWidget {
  const WithdrawalListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(withdrawalListProvider.notifier);
    final pagingController = provider.pagingController;

    return InfiniteListComponent<Withdrawal>(
      pagingController: pagingController,
      itemBuilder: (context, withdrawal, index) {
        return WithdrawalTileComponent(withdrawal: withdrawal);
      },
    );
  }
}

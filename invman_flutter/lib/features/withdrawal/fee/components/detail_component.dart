import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/fee/fee.dart';

class WithdrawalFeeDetailComponent extends ConsumerWidget {
  final int id;
  const WithdrawalFeeDetailComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalFeeDetailProvider(id));
    return BaseStateComponent(
      state: state,
      onRefresh: () => ref.read(withdrawalFeeDetailProvider(id).notifier).load(),
      successBuilder: (data) => Column(
        children: [
          Text("${data.percent} %"),
          Divider(),
          Text(data.fixed.toStringPrice(ref.read(userPreferencesProvider).currency)),
          Divider(),
          Text(data.minimum.toStringPrice(ref.read(userPreferencesProvider).currency)),
        ],
      ),
    );
  }
}

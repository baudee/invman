import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalDetailComponent extends ConsumerWidget {
  final int id;
  const WithdrawalDetailComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalDetailProvider(id));
    final provider = ref.read(withdrawalDetailProvider(id).notifier);
    return BaseStateComponent(
      state: state,
      onRefresh: () => ref.read(withdrawalDetailProvider(id).notifier).load(),
      successBuilder: (data) => Column(
        children: [
          Text("${data.percent} %"),
          Divider(),
          Text(data.fixed.toStringPrice(ref.read(userPreferencesProvider).currency)),
          Divider(),
          Text(data.minimum.toStringPrice(ref.read(userPreferencesProvider).currency)),
          Divider(),
          ElevatedButton.icon(
            onPressed: () async {
              final (success, message) = await provider.delete();
              ToastUtils.message(message, success: success);
              if (success) {
                context.pop();
              }
            },
            label: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

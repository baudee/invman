import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleDetailComponent extends ConsumerWidget {
  final int id;
  const WithdrawalRuleDetailComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalRuleDetailProvider(id));
    return BaseStateComponent(
      state: state,
      onRefresh: () => ref.read(withdrawalRuleDetailProvider(id).notifier).load(),
      successBuilder: (data) => SingleChildScrollView(
        child: Column(
          children: [
            Text(data.name, overflow: TextOverflow.ellipsis),
            Divider(),
            Text("${data.currencyChangePercentage} %"),
            Divider(),
            Builder(
              builder: (_) {
                final rules = data.rules ?? [];
                if (rules.isEmpty) {
                  return Text(S.of(context).core_noItemsFound);
                } else {
                  return Column(
                    children: rules.map(
                      (fee) {
                        return WithdrawalFeeTileComponent(
                          fee: fee,
                        );
                      },
                    ).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

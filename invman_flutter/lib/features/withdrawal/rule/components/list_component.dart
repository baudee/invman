import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleListComponent extends BaseComponent {
  final void Function(WithdrawalRule)? onTileTap;

  const WithdrawalRuleListComponent({super.key, this.onTileTap});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final provider = ref.read(withdrawalRuleListProvider.notifier);
    final pagingController = provider.pagingController;
    return InfiniteListComponent<WithdrawalRule>(
      onRefresh: provider.refresh,
      pagingController: pagingController,
      itemBuilder: (context, rule, index) {
        return WithdrawalRuleTileComponent(
          rule: rule,
          onTap: onTileTap,
        );
      },
    );
  }
}

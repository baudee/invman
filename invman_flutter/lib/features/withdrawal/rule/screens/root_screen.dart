import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleRootScreen extends HookWidget {
  const WithdrawalRuleRootScreen({super.key});

  static String route() => WithdrawalRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<WithdrawalRuleListController>());
    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).withdrawal_title)),
      body: BaseStateComponent(
        state: controller,
        successBuilder: (_) => InfiniteListComponent(
          controller: controller,
          itemBuilder: (rule) => WithdrawalRuleTileComponent(
            rule: rule,
            onTap: () => router.pushRelative(WithdrawalRuleDetailScreen.route(rule.id)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.pushRelative(WithdrawalRuleEditScreen.route(0)),
        child: Icon(Icons.add),
      ),
    );
  }
}

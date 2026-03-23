import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleRootScreen extends HookWidget {
  const WithdrawalRuleRootScreen({super.key});

  static const pathSegment = '/withdrawals';
  static String route() => pathSegment;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<WithdrawalRuleListController>());
    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).withdrawal_title)),
      body: InfiniteListComponent(
        controller: controller,
        itemBuilder: (rule) => WithdrawalRuleTileComponent(
          rule: rule,
          onTap: () => router.push(WithdrawalRuleDetailScreen.route(rule.id!)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.push(WithdrawalRuleEditScreen.route(0)),
        child: Icon(Icons.add),
      ),
    );
  }
}

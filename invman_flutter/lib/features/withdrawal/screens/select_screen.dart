import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleSelectScreen extends HookWidget {
  const WithdrawalRuleSelectScreen({super.key});

  static String route() => "${WithdrawalRoutes.namespace}/select";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<WithdrawalRuleListController>());
    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).withdrawal_title)),
      body: InfiniteListComponent(
        controller: controller,
        itemBuilder: (rule) => WithdrawalRuleTileComponent(rule: rule, onTap: () => context.pop(rule)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.push("/withdrawals/0/edit"),
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/withdrawal/rule/rule.dart';

class WithdrawalRuleSelectTileComponent extends ConsumerWidget {
  final WithdrawalRule? rule;
  const WithdrawalRuleSelectTileComponent({super.key, this.rule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(investmentFormProvider(rule?.id ?? 0).notifier);
    if (rule == null) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(S.of(context).withdrawal_addRule),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final object = await context.push(WithdrawalRuleSelectScreen.route());
          if (object is WithdrawalRule) {
            provider.setWithdrawalRule(object);
          }
        },
      );
    } else {
      return WithdrawalRuleTileComponent(
        contentPadding: EdgeInsets.zero,
        trailing: Icon(Icons.arrow_forward_ios),
        rule: rule!,
        onTap: (_) async {
          final object = await context.push(WithdrawalRuleSelectScreen.route());
          if (object is WithdrawalRule) {
            provider.setWithdrawalRule(object);
          }
        },
      );
    }
  }
}

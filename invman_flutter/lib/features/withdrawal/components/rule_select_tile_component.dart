import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleSelectTileComponent extends StatelessWidget {
  final WithdrawalRule? rule;
  final void Function(WithdrawalRule) onRuleSelected;
  const WithdrawalRuleSelectTileComponent({super.key, this.rule, required this.onRuleSelected});

  @override
  Widget build(BuildContext context) {
    if (rule == null) {
      return ListTile(
        title: Text(S.of(context).withdrawal_addRule),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final object = await router.push(WithdrawalRuleSelectScreen.route());
          if (object is WithdrawalRule) {
            onRuleSelected(object);
          }
        },
      );
    } else {
      return WithdrawalRuleTileComponent(
        trailing: Icon(Icons.arrow_forward_ios),
        rule: rule!,
        onTap: () async {
          final object = await router.push(WithdrawalRuleSelectScreen.route());
          if (object is WithdrawalRule) {
            onRuleSelected(object);
          }
        },
      );
    }
  }
}

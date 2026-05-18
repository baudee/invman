import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleSelectTileComponent extends StatelessWidget {
  final WithdrawalRule? rule;
  final void Function(WithdrawalRule) onRuleSelected;
  final VoidCallback? onRemove;
  const WithdrawalRuleSelectTileComponent({
    super.key,
    this.rule,
    required this.onRuleSelected,
    this.onRemove,
  });

  Future<void> _pick() async {
    final object = await router.push(WithdrawalRuleSelectScreen.route());
    if (object is WithdrawalRule) {
      onRuleSelected(object);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (rule == null) {
      return ListTile(
        title: Text(S.of(context).withdrawal_addRule),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: _pick,
      );
    }
    final trailing = onRemove != null
        ? IconButton(
            icon: const Icon(Icons.close),
            tooltip: S.of(context).core_delete,
            onPressed: onRemove,
          )
        : const Icon(Icons.arrow_forward_ios);
    return WithdrawalRuleTileComponent(
      trailing: trailing,
      rule: rule!,
      onTap: _pick,
    );
  }
}

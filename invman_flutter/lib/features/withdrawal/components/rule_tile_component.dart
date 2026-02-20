import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class WithdrawalRuleTileComponent extends StatelessWidget {
  final WithdrawalRule rule;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? trailing;

  const WithdrawalRuleTileComponent({super.key, required this.rule, this.onTap, this.contentPadding, this.trailing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: ListTile(
        contentPadding: contentPadding,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(Icons.rule, color: theme.colorScheme.primary, size: UIConstants.iconMd),
        ),
        title: Text(rule.name),
        trailing: trailing,
        subtitle: Text('${S.of(context).withdrawal_currency_percentage}: ${rule.currencyChangePercentage}%'),
        onTap: onTap,
      ),
    );
  }
}

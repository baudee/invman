import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleTileComponent extends ConsumerWidget {
  final WithdrawalRule rule;
  final void Function(WithdrawalRule)? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? trailing;

  const WithdrawalRuleTileComponent({super.key, required this.rule, this.onTap, this.contentPadding, this.trailing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: contentPadding,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(
          Icons.rule,
          color: theme.colorScheme.primary,
          size: UIConstants.iconMd,
        ),
      ),
      title: Text(rule.name),
      trailing: trailing,
      subtitle: Text('${S.of(context).withdrawal_currency_percentage}: ${rule.currencyChangePercentage}%'),
      onTap: onTap != null ? () => onTap!(rule) : () => router.pushRelative(WithdrawalRuleDetailScreen.route(rule.id)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
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
    return ListTile(
      title: Text(rule.name, overflow: TextOverflow.ellipsis),
      onTap: onTap != null ? () => onTap!(rule) : () => router.pushRelative(WithdrawalRuleDetailScreen.route(rule.id)),
      contentPadding: contentPadding,
      trailing: trailing,
    );
  }
}

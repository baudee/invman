import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleTileComponent extends ConsumerWidget {
  final WithdrawalRule rule;

  const WithdrawalRuleTileComponent({super.key, required this.rule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(rule.name, overflow: TextOverflow.ellipsis),
      onTap: () => context.pushRelative(WithdrawalRuleDetailScreen.route(rule.id)),
    );
  }
}

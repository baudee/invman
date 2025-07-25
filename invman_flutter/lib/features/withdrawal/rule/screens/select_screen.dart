import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleSelectScreen extends ConsumerWidget {
  const WithdrawalRuleSelectScreen({super.key});
  static String route() => "${WithdrawalRoutes.namespace}/select";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).withdrawal_title),
      ),
      body: WithdrawalRuleListComponent(
        onTileTap: (rule) => context.pop(rule),
      ),
    );
  }
}

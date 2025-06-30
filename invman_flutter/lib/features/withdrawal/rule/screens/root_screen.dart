import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleRootScreen extends StatelessWidget {
  const WithdrawalRuleRootScreen({super.key});

  static String route() => WithdrawalRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).withdrawal_title),
      ),
      body: WithdrawalRuleListComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRelative(WithdrawalRuleEditScreen.route(0));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

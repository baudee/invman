import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRootScreen extends StatelessWidget {
  const WithdrawalRootScreen({super.key});

  static String route() => WithdrawalRoutes.namespace;
  static String absoluteRoute() => "${AccountRoutes.namespace}${WithdrawalRoutes.namespace}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).withdrawal_title),
      ),
      body: WithdrawalListComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(WithdrawalEditScreen.absoluteRoute(0));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

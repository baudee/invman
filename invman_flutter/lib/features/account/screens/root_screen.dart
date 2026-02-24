import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/account/account.dart';

class AccountRootScreen extends StatelessWidget {
  const AccountRootScreen({super.key});

  static String route() => AccountRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/images/logo.png")),
        title: Text(S.of(context).account_title),
      ),
      body: AccountRootComponent(),
    );
  }
}

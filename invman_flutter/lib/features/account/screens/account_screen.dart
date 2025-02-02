import 'package:flutter/material.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/generated/l10n.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static String route() => AccountRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).menuTitle),
      ),
      body: AccountComponent(),
    );
  }
}

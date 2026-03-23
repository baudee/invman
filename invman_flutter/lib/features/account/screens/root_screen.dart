import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/account/account.dart';

class AccountRootScreen extends HookWidget {
  const AccountRootScreen({super.key});

  static String route() => AccountRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<AccountController>(), []);
    return BaseScreen(
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/images/logo.webp")),
        title: Text(S.of(context).account_title),
      ),
      body: AccountRootComponent(controller: controller),
    );
  }
}

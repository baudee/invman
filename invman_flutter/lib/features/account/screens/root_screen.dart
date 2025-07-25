import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/account/account.dart';

class AccountRootScreen extends BaseScreen {
  const AccountRootScreen({super.key});

  static String route() => AccountRoutes.namespace;

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(S.of(context).account_title),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return AccountRootComponent();
  }
}

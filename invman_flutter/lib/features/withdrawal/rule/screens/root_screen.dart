import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleRootScreen extends BaseScreen {
  const WithdrawalRuleRootScreen({super.key});

  static String route() => WithdrawalRoutes.namespace;

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(S.of(context).withdrawal_title),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return WithdrawalRuleListComponent();
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        router.pushRelative(WithdrawalRuleEditScreen.route(0));
      },
      child: Icon(Icons.add),
    );
  }
}

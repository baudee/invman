import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class AccountRoutes {
  static String namespace = "/account";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Account Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: AccountRootScreen.route(),
        builder: (_, __) => AccountRootScreen(),
        routes: [
          ...WithdrawalRoutes.routes,
        ],
      ),
    ],
  );
}

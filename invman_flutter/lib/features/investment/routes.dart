import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRoutes {
  static String namespace = "/investment";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Investment Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: InvestmentRootScreen.route(),
        builder: (_, __) => InvestmentRootScreen(),
      ),
    ],
  );
}

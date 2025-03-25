import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRoutes {
  static String namespace = "/stock";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Stock Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: StockRootScreen.route(),
        builder: (_, __) => StockRootScreen(),
      ),
      GoRoute(
        path: StockSearchScreen.route(),
        builder: (_, __) => StockSearchScreen(),
      ),
    ],
  );
}

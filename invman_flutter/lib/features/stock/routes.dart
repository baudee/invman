import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRoutes {
  static String namespace = "/stocks";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: "Stock Shell",
  );

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: StockSearchScreen.route(),
        builder: (_, _) => StockSearchScreen(),
      ),
      GoRoute(
        path: StockSelectScreen.route(),
        builder: (_, _) => StockSelectScreen(),
      ),
      GoRoute(
        path: StockDetailScreen.route(),
        builder: (_, state) => StockDetailScreen(
          uuid: UuidValue.fromString(state.pathParameters['uuid'] ?? ''),
        ),
      ),
    ],
  );
}

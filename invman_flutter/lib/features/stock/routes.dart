import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRoutes {
  static String namespace = "/stocks";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Stock Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: StockRootScreen.pathSegment,
        builder: (_, _) => const StockRootScreen(),
        routes: [
          GoRoute(path: StockSearchScreen.pathSegment, builder: (_, _) => const StockSearchScreen()),
          GoRoute(path: StockSelectScreen.pathSegment, builder: (_, _) => const StockSelectScreen()),
          GoRoute(
            path: PopularStocksScreen.pathSegment,
            builder: (_, state) {
              StockType type;
              if (state.extra != null) {
                if (state.extra is StockType) {
                  type = state.extra as StockType;
                } else {
                  type = StockType.stock;
                }
              } else {
                type = StockType.stock;
              }

              return PopularStocksScreen(
                type: type,
              );
            },
          ),
          GoRoute(path: LikedStocksScreen.pathSegment, builder: (_, _) => const LikedStocksScreen()),
          GoRoute(
            path: StockDetailScreen.pathSegment,
            builder: (_, state) => StockDetailScreen(uuid: UuidValue.fromString(state.pathParameters['uuid'] ?? '')),
          ),
        ],
      ),
    ],
  );
}

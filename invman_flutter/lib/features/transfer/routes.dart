import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferRoutes {
  static String namespace = "/transfer";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Trasnfer Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: TransferRootScreen.route(),
        builder: (_, __) => TransferRootScreen(),
      ),
      GoRoute(
        path: TransferEditScreen.route(),
        builder: (_, state) => TransferEditScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
      ),
      GoRoute(
        path: TransferDetailScreen.route(),
        builder: (_, state) => TransferDetailScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
      ),
    ],
  );
}

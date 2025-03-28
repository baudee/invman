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
    ],
  );
}

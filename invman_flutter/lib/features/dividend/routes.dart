import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/dividend/dividend.dart';

class DividendRoutes {
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Dividend Shell');

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: DividendRootScreen.pathSegment,
        builder: (_, _) => const DividendRootScreen(),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';

part 'app_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
late GoRouter router;

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final initialRoute = InvestmentRootScreen.route();
  String destination = initialRoute;

  return GoRouter(
    initialLocation: initialRoute,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(path: SignInScreen.route(), builder: (_, __) => SignInScreen()),
      StatefulShellRoute.indexedStack(
        branches: [
          InvestmentRoutes.branch,
          StockRoutes.branch,
          AccountRoutes.branch,
        ],
        builder: (context, state, navigationShell) {
          return AppContainer(navigationShell: navigationShell);
        },
      ),
    ],
    refreshListenable: ref.watch(routerNotifierProvider),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState is AuthStateSuccess;
      final location = state.matchedLocation;

      final namespaceWhiteList = [];

      final isGoingToLogin = location == SignInScreen.route();
      if (!isGoingToLogin &&
          namespaceWhiteList.any((e) => e == state.fullPath)) {
        return null;
      }

      if (!isLoggedIn && isGoingToLogin) {
        return null;
      }

      if (!isLoggedIn && !isGoingToLogin) {
        destination = location;
        return SignInScreen.route();
      }

      if (isLoggedIn && isGoingToLogin) {
        return destination;
      }

      return null;
    },
  );
}

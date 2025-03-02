import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final initialRoute = AccountScreen.route();
  String destination = initialRoute;
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: initialRoute,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: LoginScreen.route(),
        builder: (_, __) => LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.route(),
        builder: (_, __) => RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        branches: [
          AccountRoutes.branch,
        ],
        builder: (context, state, navigationShell) {
          return AppContainer(navigationShell: navigationShell);
        },
      )
    ],
    refreshListenable: ref.watch(routerNotifierProvider),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState is AuthStateSuccess;
      final location = state.matchedLocation;

      final namespaceWhiteList = [];

      final isGoingToLogin = location == LoginScreen.route() || location == RegisterScreen.route();
      if (!isGoingToLogin && namespaceWhiteList.any((e) => e == state.fullPath)) {
        return null;
      }

      if (!isLoggedIn && isGoingToLogin) {
        return null;
      }

      if (!isLoggedIn && !isGoingToLogin) {
        destination = location;
        return LoginScreen.route();
      }

      if (isLoggedIn && isGoingToLogin) {
        return destination;
      }

      return null;
    },
  );
}

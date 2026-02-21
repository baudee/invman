import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/auth/auth.dart';

import 'containers/containers.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
GoRouter get router => getIt<GoRouter>();

@module
abstract class RouterModule {
  @singleton
  GoRouter router(AuthManager authManager) {
    final initialRoute = StockRootScreen.route();
    String destination = initialRoute;

    return GoRouter(
      initialLocation: initialRoute,
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(path: SignInScreen.route(), builder: (_, _) => SignInScreen()),
        ...OnboardingRoutes.routes,
        StatefulShellRoute.indexedStack(
          branches: [StockRoutes.branch, InvestmentRoutes.branch, AccountRoutes.branch],
          builder: (context, state, navigationShell) {
            return AppContainer(navigationShell: navigationShell);
          },
        ),
      ],
      refreshListenable: authManager.state,
      redirect: (context, state) {
        final isLoggedIn = authManager.isLoggedIn.value;
        final isOnboarded = authManager.isOnboarded.value;
        final location = state.matchedLocation;

        final isGoingToLogin = location == SignInScreen.route();
        final isGoingToOnboarding = location == OnboardingRootScreen.route();

        if (!isLoggedIn && isGoingToLogin) {
          return null;
        }

        if (!isLoggedIn && !isGoingToLogin) {
          destination = location;
          return SignInScreen.route();
        }

        if (isLoggedIn && !isOnboarded) {
          return OnboardingRootScreen.route();
        }

        if (isLoggedIn && (isGoingToLogin || isGoingToOnboarding)) {
          return destination;
        }

        return null;
      },
    );
  }
}

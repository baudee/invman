import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/app_settings/app_settings.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:signals_flutter/signals_flutter.dart';

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
        GoRoute(path: MaintenanceScreen.route(), builder: (_, _) => const MaintenanceScreen()),
        GoRoute(path: UpdateRequiredScreen.route(), builder: (_, _) => const UpdateRequiredScreen()),
        GoRoute(path: SignInScreen.route(), builder: (_, _) => SignInScreen()),
        ...OnboardingRoutes.routes,
        StatefulShellRoute.indexedStack(
          branches: [StockRoutes.branch, InvestmentRoutes.branch, AccountRoutes.branch],
          builder: (context, state, navigationShell) {
            return AppContainer(navigationShell: navigationShell);
          },
        ),
      ],
      refreshListenable: signal(authManager.state),
      redirect: (context, state) {
        final appSettingsStatus = getIt<AppSettingsManager>().status.value;
        final location = state.matchedLocation;

        // App settings routes are terminal - no redirect from them
        if (location == MaintenanceScreen.route() || location == UpdateRequiredScreen.route()) {
          return null;
        }

        // Block access if maintenance or update required
        if (appSettingsStatus == AppSettingsStatus.maintenance) {
          return MaintenanceScreen.route();
        }
        if (appSettingsStatus == AppSettingsStatus.updateRequired) {
          return UpdateRequiredScreen.route();
        }

        final isLoggedIn = authManager.isLoggedIn.value;
        final isOnboarded = authManager.isOnboarded.value;

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

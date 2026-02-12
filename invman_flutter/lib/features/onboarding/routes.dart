import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';

class OnboardingRoutes {
  static String namespace = "/onboarding";

  static final routes = [GoRoute(path: OnboardingRootComponent.route(), builder: (_, _) => OnboardingRootScreen())];
}

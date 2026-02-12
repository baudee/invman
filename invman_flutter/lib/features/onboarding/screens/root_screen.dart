import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';

class OnboardingRootScreen extends BaseScreen {
  const OnboardingRootScreen({super.key});

  static String route() => OnboardingRoutes.namespace;

  @override
  Widget body(BuildContext context) {
    final controller = getIt<OnboardingController>();
    return BaseStateComponent(
      state: controller.currencies,
      successBuilder: (_) => OnboardingRootComponent(controller: controller),
    );
  }
}

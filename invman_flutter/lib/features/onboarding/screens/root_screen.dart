import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';

class OnboardingRootScreen extends HookWidget {
  const OnboardingRootScreen({super.key});

  static String route() => OnboardingRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<OnboardingController>());
    return BaseScreen(
      body: BaseStateComponent(
        state: controller,
        successBuilder: (_) => OnboardingRootComponent(controller: controller),
      ),
    );
  }
}

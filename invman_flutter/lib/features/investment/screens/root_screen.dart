import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRootScreen extends HookWidget {
  const InvestmentRootScreen({super.key});

  static const pathSegment = '/investments';
  static String route() => pathSegment;

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<InvestmentListController>());
    final authManager = getIt<AuthManager>();
    final preferencesManager = getIt<UserPreferencesManager>();

    return BaseScreen(
      usePadding: false,
      useTopSafeArea: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.push(InvestmentEditScreen.route(0)),
        child: const Icon(Icons.add),
      ),
      body: InvestmentRootComponent(
        controller: controller,
        currencyCode: authManager.currencyCode,
        preferencesManager: preferencesManager,
      ),
    );
  }
}

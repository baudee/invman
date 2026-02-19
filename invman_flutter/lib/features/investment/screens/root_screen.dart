import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRootScreen extends HookWidget {
  const InvestmentRootScreen({super.key});

  static String route() => InvestmentRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<InvestmentListController>());
    return BaseScreen(
      body: InfiniteListComponent(
        controller: controller,
        itemBuilder: (investment) => InvestmentTileComponent(investment: investment),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.pushRelative(InvestmentEditScreen.route(0)),
        child: Icon(Icons.add),
      ),
    );
  }
}

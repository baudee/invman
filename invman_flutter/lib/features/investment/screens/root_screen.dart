import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRootScreen extends BaseScreen {
  const InvestmentRootScreen({super.key});

  static String route() => InvestmentRoutes.namespace;

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return InvestmentSliverListComponent();
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        router.pushRelative(InvestmentEditScreen.route(0));
      },
      child: Icon(Icons.add),
    );
  }
}

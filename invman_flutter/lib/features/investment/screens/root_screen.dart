import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRootScreen extends BaseScreen {
  const InvestmentRootScreen({super.key});

  static String route() => InvestmentRoutes.namespace;

  @override
  Widget body(BuildContext context) {
    return InvestmentListComponent();
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        getIt<GoRouter>().pushRelative(InvestmentEditScreen.route(0));
      },
      child: Icon(Icons.add),
    );
  }
}

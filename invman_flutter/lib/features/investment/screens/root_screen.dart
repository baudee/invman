import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRootScreen extends StatelessWidget {
  const InvestmentRootScreen({super.key});

  static String route() => InvestmentRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).investment_title),
      ),
      body: InvestmentSliverListComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(".${InvestmentEditScreen.route(0)}");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

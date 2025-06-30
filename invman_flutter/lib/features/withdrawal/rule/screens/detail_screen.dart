import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleDetailScreen extends StatelessWidget {
  final int id;
  const WithdrawalRuleDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          EditIconButton(
            onPressed: () => context.pushRelative(WithdrawalRuleEditScreen.route()),
          ),
        ],
      ),
      body: WithdrawalRuleDetailComponent(id: id),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRelative(WithdrawalFeeEditScreen.route(0));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

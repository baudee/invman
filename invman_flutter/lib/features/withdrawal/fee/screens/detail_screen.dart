import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeDetailScreen extends StatelessWidget {
  final int id;
  const WithdrawalFeeDetailScreen({super.key, required this.id});
  static String route([int? id]) => "${WithdrawalRoutes.namespaceFee}/${id ?? ':idFee'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          EditIconButton(
            onPressed: () => context.pushRelative(WithdrawalFeeEditScreen.route()),
          ),
        ],
      ),
      body: WithdrawalFeeDetailComponent(id: id),
    );
  }
}

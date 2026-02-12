import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeEditScreen extends StatefulWidget {
  final int ruleId;
  final int id;
  const WithdrawalFeeEditScreen({super.key, required this.ruleId, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "${WithdrawalRoutes.namespaceFee}/$id/edit";

  @override
  State<WithdrawalFeeEditScreen> createState() => _WithdrawalFeeEditScreenState();
}

class _WithdrawalFeeEditScreenState extends State<WithdrawalFeeEditScreen> {
  late final WithdrawalFeeFormController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<WithdrawalFeeFormController>(param1: widget.ruleId, param2: widget.id);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id == 0 ? S.of(context).withdrawal_fee_create : S.of(context).withdrawal_fee_edit)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: WithdrawalFeeFormComponent(controller: controller),
      ),
    );
  }
}

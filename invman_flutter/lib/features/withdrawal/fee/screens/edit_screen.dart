import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeEditScreen extends StatelessWidget {
  final int ruleId;
  final int id;
  const WithdrawalFeeEditScreen({super.key, required this.ruleId, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "${WithdrawalRoutes.namespaceFee}/$id/edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? S.of(context).withdrawal_fee_create : S.of(context).withdrawal_fee_edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.appVerticalPadding),
        child: WithdrawalFeeFormComponent(ruleId: ruleId, id: id),
      ),
    );
  }
}

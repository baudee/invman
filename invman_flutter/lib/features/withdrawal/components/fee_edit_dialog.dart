import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeEditDialog extends StatelessWidget {
  final WithdrawalRuleEditController controller;

  const WithdrawalFeeEditDialog({super.key, required this.controller});

  static Future<bool> show({required BuildContext context, required WithdrawalRuleEditController controller}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => WithdrawalFeeEditDialog(controller: controller),
    );
    return result ?? false;
  }

  void _onConfirm(BuildContext context) {
    if (controller.saveFee()) {
      Navigator.of(context).pop(true);
    }
  }

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();
    final l10n = S.of(context);

    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
      title: Text(controller.isEditingFee ? l10n.withdrawal_fee_edit : l10n.withdrawal_fee_create),
      content: Form(
        key: controller.feeFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.feePercentController,
              validator: ValidationUtils.formValidatorDouble,
              decoration: InputDecoration(label: Text(l10n.withdrawal_percentage), suffixText: '%'),
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.feeFixedController,
              validator: ValidationUtils.formValidatorDouble,
              decoration: InputDecoration(label: Text(l10n.withdrawal_fixed), suffixText: authManager.currencyCode),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.feeMinimumController,
              validator: ValidationUtils.formValidatorDouble,
              decoration: InputDecoration(label: Text(l10n.withdrawal_minimum), suffixText: authManager.currencyCode),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => _onCancel(context), child: Text(l10n.core_cancel)),
        TextButton(onPressed: () => _onConfirm(context), child: Text(l10n.core_save)),
      ],
    );
  }
}

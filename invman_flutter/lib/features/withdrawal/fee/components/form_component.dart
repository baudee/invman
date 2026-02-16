import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/fee/fee.dart';

class WithdrawalFeeFormComponent extends HookWidget {
  final WithdrawalFeeEditController controller;
  const WithdrawalFeeFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final authManager = useMemoized(() => getIt<AuthManager>());

    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.percentController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(
                label: Text(S.of(context).withdrawal_percentage),
                suffixText: "%",
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: controller.fixedController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(
                label: Text(S.of(context).withdrawal_fixed),
                suffixText: authManager.currencyCode,
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: controller.minimumController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(
                label: Text(S.of(context).withdrawal_minimum),
                suffixText: authManager.currencyCode,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            SaveButton(
              onPressed: () async {
                final (success, message) = await controller.submit();
                ToastUtils.message(message, success: success);
                if (success) {
                  router.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

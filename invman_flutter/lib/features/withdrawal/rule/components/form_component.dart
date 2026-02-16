import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleFormComponent extends StatelessWidget {
  final WithdrawalRuleEditController controller;
  const WithdrawalRuleFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.nameController,
              validator: (value) => ValidationUtils.formValidatorNotEmpty(
                value,
                S.of(context).core_name,
              ),
              decoration: InputDecoration(label: Text(S.of(context).core_name)),
            ),
            TextFormField(
              controller: controller.currencyChangePercentageController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(
                label: Text(S.of(context).withdrawal_currency_percentage),
                suffixText: "%",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            SaveButton(
              onPressed: () async {
                final isCreate = controller.id == 0;
                final (success, message) = await controller.submit();
                ToastUtils.message(message, success: success);
                if (success) {
                  if (isCreate) {
                    final savedRule = controller.value.value!;
                    final currentPath = router.state.uri.path;
                    final basePath = currentPath.replaceAll(
                      RegExp(r'/\d+/edit$'),
                      '',
                    );
                    router.pushReplacement('$basePath/${savedRule.id}');
                  } else {
                    router.pop();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

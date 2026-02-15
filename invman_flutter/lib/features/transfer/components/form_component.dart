import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferFormComponent extends HookWidget {
  final TransferEditController controller;
  const TransferFormComponent({super.key, required this.controller});

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
              controller: controller.amountController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).transfer_amount), suffixText: authManager.currencyCode),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: controller.quantityController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).transfer_quantity), suffixText: authManager.currencyCode),
              keyboardType: TextInputType.number,
            ),
            CalendarDatePicker(
              initialDate: controller.value.requireValue.createdAt,
              firstDate: DateTime(1970),
              lastDate: DateTime.now(),
              onDateChanged: (date) => {controller.setTransferDate(date)},
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

import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TransferFormComponent extends StatelessWidget {
  final TransferEditController controller;
  const TransferFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();

    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller.amountController,
            validator: (value) => ValidationUtils.formValidatorDouble(value),
            decoration: InputDecoration(
              label: Text(S.of(context).transfer_amount),
              suffixText: authManager.currencyCode,
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: controller.quantityController,
            validator: (value) => ValidationUtils.formValidatorDouble(value),
            decoration: InputDecoration(
              label: Text(S.of(context).transfer_quantity),
              suffixText: authManager.currencyCode,
            ),
            keyboardType: TextInputType.number,
          ),
          SectionHeaderComponent(title: S.of(context).transfer_date),
          CalendarDatePicker(
            initialDate: controller.state.watch(context).requireValue.createdAt,
            firstDate: DateTime(1970),
            lastDate: DateTime.now(),
            onDateChanged: (date) => {controller.setTransferDate(date)},
          ),
          Spacer(),
          SaveButton(
            onPressed: () async {
              final (success, message) = await controller.submit();
              ToastUtils.message(message, success: success);
              if (success) {
                router.pop();
              }
            },
          ),
          SizedBox(height: UIConstants.spacingMd),
        ],
      ),
    );
  }
}

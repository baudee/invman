import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferFormComponent extends StatelessWidget {
  final TransferFormController controller;
  const TransferFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final currency = (getIt<AuthController>().state.value as AuthStateSuccess).account.currency;

    return controller.state.value.map(
      data: (data) => _buildForm(context, data, currency),
      error: (error, _) => ErrorComponent(error: error, handleRefresh: () => controller.state.refresh()),
      loading: () => const LoadingComponent(),
    );
  }

  Widget _buildForm(BuildContext context, Transfer data, Currency? currency) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.amountController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).transfer_amount), suffixText: currency?.code),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: controller.quantityController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).transfer_quantity), suffixText: currency?.code),
              keyboardType: TextInputType.number,
            ),
            CalendarDatePicker(
              initialDate: data.createdAt,
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
                  getIt<GoRouter>().pop();
                }
              },
            ),
            const SizedBox(height: UIConstants.spacingXs),
            DeleteButton(
              onPressed: () async {
                final (success, message) = await controller.delete();
                ToastUtils.message(message, success: success);
                if (success) {
                  getIt<GoRouter>().pop();
                  getIt<GoRouter>().pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

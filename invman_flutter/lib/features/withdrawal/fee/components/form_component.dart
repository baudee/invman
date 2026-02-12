import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/fee/fee.dart';

class WithdrawalFeeFormComponent extends StatelessWidget {
  final WithdrawalFeeFormController controller;
  const WithdrawalFeeFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final currency = (getIt<AuthController>().state.value as AuthStateSuccess).account.currency;

    return controller.state.value.map(
      data: (data) => _buildForm(context, data, currency),
      error: (error, _) => ErrorComponent(error: error, handleRefresh: () => controller.state.refresh()),
      loading: () => const LoadingComponent(),
    );
  }

  Widget _buildForm(BuildContext context, WithdrawalFee data, Currency? currency) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.percentController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).withdrawal_percentage), suffixText: "%"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: controller.fixedController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).withdrawal_fixed), suffixText: currency?.code),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: controller.minimumController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).withdrawal_minimum), suffixText: currency?.code),
              keyboardType: TextInputType.number,
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
            if (controller.id != 0) ...[
              const SizedBox(height: UIConstants.spacingXs),
              DeleteButton(
                onPressed: () async {
                  final (success, message) = await controller.delete();
                  ToastUtils.message(message, success: success);
                  if (success) {
                    getIt<GoRouter>().pop();
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

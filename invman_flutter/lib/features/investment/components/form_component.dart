import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentFormComponent extends StatelessWidget {
  final InvestmentFormController controller;
  const InvestmentFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseStateComponent(
      state: controller.state,
      successBuilder: (investment) => Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.nameController,
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).core_name),
                decoration: InputDecoration(label: Text(S.of(context).core_name)),
              ),
              SizedBox(height: UIConstants.spacingXs),
              WithdrawalRuleSelectTileComponent(
                rule: investment.withdrawalRule,
                onRuleSelected: controller.setWithdrawalRule,
              ),
              SizedBox(height: UIConstants.spacingXs),
              StockSelectTileComponent(stock: investment.stock, onStockSelected: controller.setStock),
              SizedBox(height: UIConstants.spacingMd),
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
      ),
    );
  }
}

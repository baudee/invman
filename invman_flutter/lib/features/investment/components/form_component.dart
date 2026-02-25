import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentFormComponent extends StatelessWidget {
  final InvestmentEditController controller;
  const InvestmentFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseStateComponent(
      state: controller,
      successBuilder: (investment) => Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.nameController,
              validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).core_name),
              decoration: InputDecoration(label: Text(S.of(context).core_name)),
            ),
            SizedBox(height: UIConstants.spacingSm),
            SectionHeaderComponent(title: S.of(context).withdrawal_selection),
            SizedBox(height: UIConstants.spacingXs),
            WithdrawalRuleSelectTileComponent(
              rule: investment.withdrawalRule,
              onRuleSelected: controller.setWithdrawalRule,
            ),
            SizedBox(height: UIConstants.spacingXs),
            SectionHeaderComponent(title: S.of(context).stock_selection),
            SizedBox(height: UIConstants.spacingXs),
            StockSelectTileComponent(stock: investment.stock, onStockSelected: controller.setStock),
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
            SizedBox(height: UIConstants.spacingSm),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:signals_flutter/signals_flutter.dart';

class WithdrawalRuleFormComponent extends StatelessWidget {
  final WithdrawalRuleEditController controller;
  const WithdrawalRuleFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.nameController,
            validator: (value) => ValidationUtils.formValidatorNotEmpty(value, l10n.core_name),
            decoration: InputDecoration(label: Text(l10n.core_name)),
          ),
          TextFormField(
            controller: controller.currencyChangePercentageController,
            validator: (value) => ValidationUtils.formValidatorDouble(value),
            decoration: InputDecoration(label: Text(l10n.withdrawal_currency_percentage), suffixText: "%"),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: UIConstants.spacingXl),
          _buildFeesSection(context, l10n, theme),
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
          const SizedBox(height: UIConstants.spacingMd),
        ],
      ),
    );
  }

  Widget _buildFeesSection(BuildContext context, S l10n, ThemeData theme) {
    final fees = controller.fees.watch(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.withdrawal_fees, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _onAddFee(context),
              tooltip: l10n.withdrawal_fee_create,
            ),
          ],
        ),
        const SizedBox(height: UIConstants.spacingSm),
        if (fees.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: UIConstants.spacingMd),
            child: Text(
              l10n.core_noItemsFound,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
            ),
          )
        else
          ...fees.asMap().entries.map((entry) {
            final index = entry.key;
            final fee = entry.value;
            return _buildFeeTile(context, fee, index, theme, l10n);
          }),
      ],
    );
  }

  Widget _buildFeeTile(BuildContext context, WithdrawalFee fee, int index, ThemeData theme, S l10n) {
    return Card(
      margin: const EdgeInsets.only(bottom: UIConstants.spacingSm),
      child: WithdrawalFeeTileComponent(
        fee: fee,
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () => controller.removeFee(index),
          tooltip: l10n.core_delete,
        ),
        onTap: () => _onEditFee(context, index),
      ),
    );
  }

  Future<void> _onAddFee(BuildContext context) async {
    controller.initFeeForAdd();
    await WithdrawalFeeEditDialog.show(context: context, controller: controller);
  }

  Future<void> _onEditFee(BuildContext context, int index) async {
    controller.initFeeForEdit(index);
    await WithdrawalFeeEditDialog.show(context: context, controller: controller);
  }
}

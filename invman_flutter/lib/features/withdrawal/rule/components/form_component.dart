import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:signals_flutter/signals_flutter.dart';

class WithdrawalRuleFormComponent extends StatelessWidget {
  final WithdrawalRuleEditController controller;
  const WithdrawalRuleFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final authManager = getIt<AuthManager>();

    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.nameController,
              validator: (value) =>
                  ValidationUtils.formValidatorNotEmpty(value, l10n.core_name),
              decoration: InputDecoration(label: Text(l10n.core_name)),
            ),
            TextFormField(
              controller: controller.currencyChangePercentageController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(
                label: Text(l10n.withdrawal_currency_percentage),
                suffixText: "%",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: UIConstants.spacingXl),
            _buildFeesSection(context, l10n, theme, authManager),
            const SizedBox(height: UIConstants.spacingLg),
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

  Widget _buildFeesSection(
    BuildContext context,
    S l10n,
    ThemeData theme,
    AuthManager authManager,
  ) {
    final fees = controller.fees.watch(context);
    final ruleId = controller.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.withdrawal_fees,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _onAddFee(context, ruleId),
              tooltip: l10n.withdrawal_fee_create,
            ),
          ],
        ),
        const SizedBox(height: UIConstants.spacingSm),
        if (fees.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: UIConstants.spacingMd,
            ),
            child: Text(
              l10n.core_noItemsFound,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
          )
        else
          ...fees.asMap().entries.map((entry) {
            final index = entry.key;
            final fee = entry.value;
            return _buildFeeTile(
              context,
              fee,
              index,
              ruleId,
              theme,
              authManager,
              l10n,
            );
          }),
      ],
    );
  }

  Widget _buildFeeTile(
    BuildContext context,
    WithdrawalFee fee,
    int index,
    int ruleId,
    ThemeData theme,
    AuthManager authManager,
    S l10n,
  ) {
    final summary = _buildFeeSummary(fee, authManager);

    return Card(
      margin: const EdgeInsets.only(bottom: UIConstants.spacingSm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            Icons.percent,
            color: theme.colorScheme.primary,
            size: UIConstants.iconMd,
          ),
        ),
        title: Text(summary),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () => controller.removeFee(index),
          tooltip: l10n.core_delete,
        ),
        onTap: () => _onEditFee(context, fee, index, ruleId),
      ),
    );
  }

  String _buildFeeSummary(WithdrawalFee fee, AuthManager authManager) {
    final parts = <String>[];

    if (fee.percent > 0) {
      parts.add('${fee.percent}%');
    }

    if (fee.fixed > 0) {
      parts.add(fee.fixed.toStringPrice(authManager.currencyCode));
    }

    if (fee.minimum > 0) {
      parts.add('(min ${fee.minimum.toStringPrice(authManager.currencyCode)})');
    }

    if (parts.isEmpty) {
      return '0%';
    }

    final mainParts = parts.where((p) => !p.startsWith('(min')).toList();
    final minPart = parts.where((p) => p.startsWith('(min')).toList();

    return '${mainParts.join(' + ')}${minPart.isNotEmpty ? ' ${minPart.first}' : ''}';
  }

  Future<void> _onAddFee(BuildContext context, int ruleId) async {
    final fee = await WithdrawalFeeEditDialog.show(
      context: context,
      ruleId: ruleId,
    );
    if (fee != null) {
      controller.addFee(fee);
    }
  }

  Future<void> _onEditFee(
    BuildContext context,
    WithdrawalFee fee,
    int index,
    int ruleId,
  ) async {
    final updatedFee = await WithdrawalFeeEditDialog.show(
      context: context,
      initialFee: fee,
      ruleId: ruleId,
    );
    if (updatedFee != null) {
      controller.updateFee(index, updatedFee);
    }
  }
}

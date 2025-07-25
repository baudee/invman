import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/rule/rule.dart';

class WithdrawalRuleFormComponent extends ConsumerWidget {
  final int id;
  const WithdrawalRuleFormComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(withdrawalRuleFormProvider(id).notifier);
    return Form(
      key: provider.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: provider.nameController,
              validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).core_name),
              decoration: InputDecoration(label: Text(S.of(context).core_name)),
            ),
            TextFormField(
              controller: provider.currencyChangePercentageController,
              validator: (value) => ValidationUtils.formValidatorDouble(value),
              decoration: InputDecoration(label: Text(S.of(context).withdrawal_currency_percentage), suffixText: "%"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 16,
            ),
            SaveButton(
              onPressed: () async {
                final (success, message) = await provider.submit();
                ToastUtils.message(message, success: success);
                if (success) {
                  router.pop();
                }
              },
            ),
            if (id != 0) ...[
              const SizedBox(height: UIConstants.spacingXs),
              DeleteButton(
                onPressed: () async {
                  final (success, message) = await provider.delete();
                  ToastUtils.message(message, success: success);
                  if (success) {
                    router.pop();
                  }
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}

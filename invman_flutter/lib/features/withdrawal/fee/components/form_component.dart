import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/fee/fee.dart';

class WithdrawalFeeFormComponent extends ConsumerWidget {
  final int id;
  final int ruleId;
  const WithdrawalFeeFormComponent({super.key, required this.ruleId, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalFeeFormProvider(ruleId, id));
    final provider = ref.read(withdrawalFeeFormProvider(ruleId, id).notifier);

    return BaseStateComponent(
      state: state,
      onErrorRefresh: () => provider.load(),
      successBuilder: (data) => Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: provider.percentController,
                validator: (value) => ValidationUtils.formValidatorDouble(value),
                decoration: InputDecoration(label: Text(S.of(context).withdrawal_percentage), suffixText: "%"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: provider.fixedController,
                validator: (value) => ValidationUtils.formValidatorDouble(value),
                decoration: InputDecoration(
                    label: Text(S.of(context).withdrawal_fixed),
                    suffixText: ref.read(userPreferencesProvider).currency),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: provider.minimumController,
                validator: (value) => ValidationUtils.formValidatorDouble(value),
                decoration: InputDecoration(
                    label: Text(S.of(context).withdrawal_minimum),
                    suffixText: ref.read(userPreferencesProvider).currency),
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
      ),
    );
  }
}

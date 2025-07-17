import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferFormComponent extends ConsumerWidget {
  final int id;
  final int investmentId;
  const TransferFormComponent({super.key, required this.id, required this.investmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferFormProvider(investmentId, id));
    final provider = ref.read(transferFormProvider(investmentId, id).notifier);

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
                controller: provider.amountController,
                validator: (value) => ValidationUtils.formValidatorDouble(value),
                decoration: InputDecoration(
                    label: Text(S.of(context).transfer_amount), suffixText: ref.read(userPreferencesProvider).currency),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: provider.quantityController,
                validator: (value) => ValidationUtils.formValidatorDouble(value),
                decoration: InputDecoration(
                    label: Text(S.of(context).transfer_quantity),
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
              DeleteButton(
                onPressed: () async {
                  final (success, message) = await provider.delete();
                  ToastUtils.message(message, success: success);
                  if (success) {
                    router.pop();
                    router.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

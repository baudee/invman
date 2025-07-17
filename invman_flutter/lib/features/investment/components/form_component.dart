import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentFormComponent extends ConsumerWidget {
  final int id;
  const InvestmentFormComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(investmentFormProvider(id));
    final provider = ref.read(investmentFormProvider(id).notifier);

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
                controller: provider.nameController,
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).core_name),
                decoration: InputDecoration(label: Text(S.of(context).core_name)),
              ),
              WithdrawalRuleSelectTileComponent(rule: data.withdrawalRule),
              StockSelectTileComponent(stock: data.stock, investmentId: data.id ?? 0),
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
              if (id != 0)
                DeleteButton(
                  onPressed: () async {
                    final (success, message) = await provider.delete();
                    ToastUtils.message(message, success: success);
                    if (success) {
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferFormComponent extends ConsumerWidget {
  final int id;
  const TransferFormComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferFormProvider(id));
    final provider = ref.read(transferFormProvider(id).notifier);

    return BaseStateComponent(
      state: state,
      successBuilder: (data) => Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: provider.amountController,
                validator: (value) => ValidationUtils.formValidatorAmount(value),
                decoration: InputDecoration(
                    label: Text(S.of(context).transfer_amount), suffixText: ref.read(userPreferencesProvider).currency),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: provider.quantityController,
                validator: (value) => ValidationUtils.formValidatorAmount(value),
                decoration: InputDecoration(
                    label: Text(S.of(context).transfer_quantity),
                    suffixText: ref.read(userPreferencesProvider).currency),
                keyboardType: TextInputType.number,
              ),
              data.stock?.name == null
                  ? ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(S.of(context).transfer_addStock),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        final stock = await context.push(StockSelectScreen.route());
                        if (stock is Stock) {
                          provider.setStock(stock);
                        }
                      },
                    )
                  : StockTileComponent(
                      contentPadding: EdgeInsets.zero,
                      stock: data.stock!,
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (stock) async {
                        final stock = await context.push(StockSelectScreen.route());
                        if (stock is Stock) {
                          provider.setStock(stock);
                        }
                      },
                    ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  final (success, message) = await provider.submit();
                  if (context.mounted) {
                    ToastUtils.message(context, message, success: success);
                    if (success) {
                      context.pop();
                    }
                  }
                },
                child: Text(S.of(context).core_save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

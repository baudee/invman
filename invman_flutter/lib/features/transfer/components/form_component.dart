import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/stock/screens/select_screen.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferFormComponent extends ConsumerWidget {
  final int id;
  const TransferFormComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferFormProvider(id));
    final provider = ref.read(transferFormProvider(id).notifier);

    return Stack(
      children: [
        IgnorePointer(
          ignoring: state.isLoading,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: state.isLoading ? 0.7 : 1,
            child: Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: provider.amountController,
                      validator: (value) => ValidationUtils.formValidatorAmount(value),
                      decoration: InputDecoration(
                          label: Text(S.of(context).transfer_amount),
                          suffixText: ref.read(userPreferencesProvider).currency),
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
                    state.object.stock?.name == null
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
                            stock: state.object.stock!,
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: (stock) async {
                              final stock = await context.push(StockSelectScreen.route());
                              if (stock is Stock) {
                                provider.setStock(stock);
                              }
                            },
                          ),
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.error!,
                          style: TextStyle(color: Colors.red.shade700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final success = await provider.submit();
                        if (context.mounted) {
                          if (success) {
                            ToastUtils.message(context, S.of(context).transfer_saved);
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
          ),
        ),
        if (state.isLoading) LoadingComponent()
      ],
    );
  }
}

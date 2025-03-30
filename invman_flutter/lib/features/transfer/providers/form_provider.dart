import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/core/utils/initial_utils.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@Riverpod(keepAlive: true)
class TransferForm extends _$TransferForm {
  @override
  ModelFormState<Transfer> build(int id) {
    Future.microtask(() => _load(id));
    return ModelFormState.initial(InitialUtils.getTransfer());
  }

  final formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final quantityController = TextEditingController();

  void _refreshControllers() {
    quantityController.text = state.object.quantity.toString();
    amountController.text = (state.object.amount / 100).toStringAsFixed(0);
  }

  void setStock(Stock stock) {
    state = state.update(
      state.object.copyWith(
        stock: stock,
      ),
    );
  }

  Future<void> _load(int id) async {
    state = state.loading();
    if (id == 0) {
      state = state.success(InitialUtils.getTransfer());
      _refreshControllers();
      return;
    }

    final result = await ref.read(transferServiceProvider).retrieve(id);

    result.fold((error) {
      state = state.failure(error);
    }, (transfer) {
      state = state.success(transfer);
      _refreshControllers();
    });
  }

  Future<bool> submit() async {
    if (!formKey.currentState!.validate()) {
      state = state.failure(S.current.error_fixToContinue);
      return false;
    }

    if (state.object.stock == null || state.object.stock?.id == null) {
      state = state.failure(S.current.transfer_selectStock);
      return false;
    }

    if (double.tryParse(quantityController.text.trim()) == null) {
      state = state.failure(S.current.transfer_selectValidQuantity);
      return false;
    }

    if (int.tryParse(amountController.text.trim()) == null) {
      state = state.failure(S.current.transfer_selectValidAmount);
      return false;
    }

    final transfer = state.object.copyWith(
      quantity: double.parse(quantityController.text.trim()),
      amount: int.parse(amountController.text.trim()) * 100,
      stockId: state.object.stock!.id!,
    );

    state = state.loading();

    final result = await ref.read(transferServiceProvider).save(transfer);

    return result.fold((error) {
      state = state.failure(error);
      return false;
    }, (t) {
      state = state.success(t);
      ref.read(transferListProvider.notifier).refresh();
      if (t.id != null) {
        ref.invalidate(transferDetailProvider(t.id!));
      }
      return true;
    });
  }
}

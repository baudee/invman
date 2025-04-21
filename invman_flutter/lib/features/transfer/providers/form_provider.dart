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
  ModelState<Transfer> build(int id) {
    Future.microtask(() => _load());
    return Loading();
  }

  final formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final quantityController = TextEditingController();

  void _refreshControllers() {
    if (state case Success<Transfer>(data: final transfer)) {
      quantityController.text = transfer.quantity.toString();
      amountController.text = (transfer.amount / 100).toStringAsFixed(0);
    }
  }

  void setStock(Stock stock) {
    if (state case Success<Transfer>(data: final transfer)) {
      state = Success(
        transfer.copyWith(
          stock: stock,
        ),
      );
    }
  }

  Future<void> _load() async {
    state = Loading();

    if (id == 0) {
      state = Success(InitialUtils.getTransfer());
      _refreshControllers();
      return;
    }

    final result = await ref.read(transferServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (transfer) {
      state = Success(transfer);
      _refreshControllers();
    });
  }

  Future<(bool, String?)> submit() async {
    if (state case Success<Transfer>(data: final transfer)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (transfer.stock == null || transfer.stock?.id == null) {
        return (false, S.current.transfer_selectStock);
      }

      if (double.tryParse(quantityController.text.trim()) == null) {
        return (false, S.current.transfer_selectValidQuantity);
      }

      if (int.tryParse(amountController.text.trim()) == null) {
        return (false, S.current.transfer_selectValidAmount);
      }

      final transferToSave = transfer.copyWith(
        quantity: double.parse(quantityController.text.trim()),
        amount: int.parse(amountController.text.trim()) * 100,
        stockId: transfer.stock!.id!,
      );

      state = Loading();

      final result = await ref.read(transferServiceProvider).save(transferToSave);

      return result.fold((error) {
        state = Success(transferToSave);
        return (false, error);
      }, (t) {
        state = Success(t);
        ref.read(transferListProvider.notifier).refresh();
        if (t.id != null) {
          ref.invalidate(transferDetailProvider(t.id!));
        }
        return (true, S.current.core_itemSaved);
      });
    }
    return (false, S.current.error_invalidState);
  }
}

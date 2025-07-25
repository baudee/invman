import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/core/utils/initial_utils.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@Riverpod()
class TransferForm extends _$TransferForm {
  @override
  ModelState<Transfer> build(int investmentId, int id) {
    Future.microtask(() => load());
    return Loading();
  }

  final formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final quantityController = TextEditingController();

  void _refreshControllers() {
    if (state case Success<Transfer>(data: final transfer)) {
      quantityController.text = transfer.quantity.toString();
      amountController.text = transfer.amount.toStringAsFixed(2);
    }
  }

  Future<void> load() async {
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

      if (double.tryParse(quantityController.text.trim()) == null) {
        return (false, S.current.transfer_selectValidQuantity);
      }

      if (double.tryParse(amountController.text.trim()) == null) {
        return (false, S.current.transfer_selectValidAmount);
      }

      final transferToSave = transfer.copyWith(
        quantity: double.parse(quantityController.text.trim()),
        amount: double.parse(amountController.text.trim()),
        investmentId: investmentId,
      );

      state = Loading();

      final result = await ref.read(transferServiceProvider).save(transferToSave);

      return result.fold((error) {
        state = Success(transferToSave);
        return (false, error);
      }, (t) {
        state = Success(t);
        ref.invalidate(investmentDetailProvider(t.investmentId));
        if (t.id != null || transfer.id == 0) {
          ref.invalidate(transferDetailProvider(t.id!));
        }
        return (true, S.current.core_itemSaved);
      });
    }
    return (false, S.current.error_invalidState);
  }

  Future<(bool, String?)> delete() async {
    if (state is! Success) {
      return (false, S.current.error_invalidState);
    }

    final transferToDelete = (state as Success).data;

    state = Loading();

    final result = await ref.read(transferServiceProvider).delete(id);

    return result.fold((error) {
      state = Success(transferToDelete);
      return (false, error);
    }, (deletedTransfer) {
      state = Success(deletedTransfer);
      ref.invalidate(investmentDetailProvider(deletedTransfer.investmentId));
      return (true, S.current.core_itemDeleted);
    });
  }
}

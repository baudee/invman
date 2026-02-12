import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/services/transfer_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class TransferFormController {
  final int investmentId;
  final int id;
  final TransferService _service;
  final InvestmentListController _investmentListController;

  late final AsyncSignal<Transfer> state;
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final quantityController = TextEditingController();

  TransferFormController(
    @factoryParam this.investmentId,
    @factoryParam this.id,
    this._service,
    this._investmentListController,
  ) {
    state = futureSignal(() => _loadInitial());
  }

  Future<Transfer> _loadInitial() async {
    if (id == 0) {
      final initial = InitialUtils.getTransfer();
      _refreshControllers(initial);
      return initial;
    }
    final transfer = await _service.retrieve(id);
    _refreshControllers(transfer);
    return transfer;
  }

  void _refreshControllers(Transfer transfer) {
    quantityController.text = transfer.quantity.toString();
    amountController.text = transfer.amount.toStringAsFixed(2);
  }

  void setTransferDate(DateTime date) {
    if (state.value case AsyncData(value: final transfer)) {
      state.value = AsyncData(transfer.copyWith(createdAt: date));
    }
  }

  Future<(bool, String?)> submit() async {
    if (state.value case AsyncData(value: final transfer)) {
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
        createdAt: transfer.createdAt.toUtc(),
      );

      state.value = AsyncLoading();

      final result = await _service.save(transferToSave);

      return result.fold(
        (error) {
          state.value = AsyncData(transferToSave);
          return (false, error);
        },
        (saved) {
          state.value = AsyncData(saved);
          _investmentListController.refresh();
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  Future<(bool, String?)> delete() async {
    if (state.value case AsyncData(value: final transferToDelete)) {
      state.value = AsyncLoading();

      final result = await _service.delete(id);

      return result.fold(
        (error) {
          state.value = AsyncData(transferToDelete);
          return (false, error);
        },
        (deletedTransfer) {
          state.value = AsyncData(deletedTransfer);
          _investmentListController.refresh();
          return (true, S.current.core_itemDeleted);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  void dispose() {
    amountController.dispose();
    quantityController.dispose();
    state.dispose();
  }
}

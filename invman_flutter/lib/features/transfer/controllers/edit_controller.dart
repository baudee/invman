import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/transfer/repositories/transfer_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class TransferEditController extends AsyncSignal<Transfer> {
  final int investmentId;
  final int id;
  final TransferRepository _service;

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final quantityController = TextEditingController();

  TransferEditController(
    @factoryParam this.investmentId,
    @factoryParam this.id,
    this._service,
  ) : super(AsyncState.loading()) {
    _load();
  }

  Future<void> _load() async {
    setLoading(value);
    if (id == 0) {
      final initial = InitialUtils.getTransfer();
      _refreshControllers(initial);
      setValue(initial);
      return;
    }
    final result = await _service.retrieve(id);
    result.fold((error) => setError(error), (transfer) {
      _refreshControllers(transfer);
      setValue(transfer);
    });
  }

  void _refreshControllers(Transfer transfer) {
    quantityController.text = transfer.quantity.toString();
    amountController.text = transfer.amount.toStringAsFixed(2);
  }

  void setTransferDate(DateTime date) {
    if (value case AsyncData(value: final transfer)) {
      setValue(transfer.copyWith(createdAt: date));
    }
  }

  Future<(bool, String?)> submit() async {
    if (value case AsyncData(value: final transfer)) {
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

      setLoading(value);

      final result = await _service.save(transferToSave);

      return result.fold(
        (error) {
          setValue(transferToSave);
          return (false, error);
        },
        (saved) {
          setValue(saved);
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }
}

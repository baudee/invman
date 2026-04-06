import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/repositories/transfer_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class TransferEditController extends Disposable {
  final int investmentId;
  final int id;
  final TransferRepository _transferRepository;
  final InvestmentRepository _investmentRepository;

  final _state = asyncSignal<Transfer>(AsyncState.loading());
  ReadonlySignal<AsyncState<Transfer>> get state => _state;

  final _isSell = Signal<bool>(false);
  ReadonlySignal<bool> get isSell => _isSell.readonly();

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final quantityController = TextEditingController();

  TransferEditController(
    @factoryParam this.investmentId,
    @factoryParam this.id,
    this._transferRepository,
    this._investmentRepository,
  ) {
    _load();
  }

  Future<void> _load() async {
    _state.value = AsyncState.loading();
    if (id == 0) {
      final initial = InitialUtils.getTransfer();
      _refreshControllers(initial);
      _state.value = AsyncState.data(initial);
      return;
    }
    final result = await _transferRepository.retrieve(id);
    result.fold((error) => _state.value = AsyncState.error(error), (transfer) {
      _refreshControllers(transfer);
      _state.value = AsyncState.data(transfer);
    });
  }

  Future<(bool, String?)> delete() => DeleteCommand(onExecute: () => _transferRepository.delete(id)).execute();

  void setIsSell(bool value) => _isSell.value = value;

  void _refreshControllers(Transfer transfer) {
    _isSell.value = transfer.quantity < 0;
    quantityController.text = transfer.quantity.abs().toString();
    amountController.text = transfer.amount.abs().toStringAsFixed(2);
  }

  void setTransferDate(DateTime date) {
    if (state.value case AsyncData(value: final transfer)) {
      _state.value = AsyncState.data(transfer.copyWith(createdAt: DateTime(date.year, date.month, date.day)));
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

      final sign = _isSell.value ? -1.0 : 1.0;
      final transferToSave = transfer.copyWith(
        quantity: double.parse(quantityController.text.trim()) * sign,
        amount: double.parse(amountController.text.trim()) * sign,
        investmentId: investmentId,
        createdAt: transfer.createdAt,
      );

      _state.value = AsyncState.loading();

      final result = await _transferRepository.save(transferToSave);

      return result.fold(
        (error) {
          _state.value = AsyncState.error(error);
          return (false, error);
        },
        (saved) {
          _state.value = AsyncState.data(saved);
          _investmentRepository.saveInvalidate();
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  void reload() => _load();

  @override
  void onDispose() {
    _state.dispose();
    _isSell.dispose();
    amountController.dispose();
    quantityController.dispose();
  }
}

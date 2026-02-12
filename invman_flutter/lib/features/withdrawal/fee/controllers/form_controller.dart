import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/services/withdrawal_fee_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalFeeFormController {
  final int ruleId;
  final int id;
  final WithdrawalFeeService _service;

  late final AsyncSignal<WithdrawalFee> state;
  final formKey = GlobalKey<FormState>();
  final percentController = TextEditingController();
  final fixedController = TextEditingController();
  final minimumController = TextEditingController();

  WithdrawalFeeFormController(
    @factoryParam this.ruleId,
    @factoryParam this.id,
    this._service,
  ) {
    state = futureSignal(() => _loadInitial());
  }

  Future<WithdrawalFee> _loadInitial() async {
    if (id == 0) {
      final initial = InitialUtils.getWithdrawalFee(ruleId: ruleId);
      _refreshControllers(initial);
      return initial;
    }
    final fee = await _service.retrieve(id);
    _refreshControllers(fee);
    return fee;
  }

  void _refreshControllers(WithdrawalFee fee) {
    percentController.text = fee.percent.toString();
    fixedController.text = fee.fixed.toStringAsFixed(2);
    minimumController.text = fee.minimum.toStringAsFixed(2);
  }

  Future<(bool, String?)> submit() async {
    if (state.value case AsyncData(value: final withdrawal)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (double.tryParse(percentController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidPercentage);
      }

      if (double.tryParse(fixedController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidFixed);
      }

      if (double.tryParse(minimumController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidMinimum);
      }

      final ruleToSave = withdrawal.copyWith(
        percent: double.parse(percentController.text.trim()),
        fixed: double.parse(fixedController.text.trim()),
        minimum: double.parse(minimumController.text.trim()),
      );

      state.value = AsyncLoading();

      final result = await _service.save(ruleToSave);

      return result.fold(
        (error) {
          state.value = AsyncData(ruleToSave);
          return (false, error);
        },
        (fee) {
          state.value = AsyncData(fee);
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  Future<(bool, String?)> delete() async {
    if (state.value case AsyncData(value: final feeToDelete)) {
      state.value = AsyncLoading();

      final result = await _service.delete(id);

      return result.fold(
        (error) {
          state.value = AsyncData(feeToDelete);
          return (false, error);
        },
        (deletedFee) {
          state.value = AsyncData(deletedFee);
          return (true, S.current.core_itemDeleted);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  void dispose() {
    percentController.dispose();
    fixedController.dispose();
    minimumController.dispose();
    state.dispose();
  }
}

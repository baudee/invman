import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/repositories/withdrawal_fee_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalFeeEditController extends AsyncSignal<WithdrawalFee> {
  final int ruleId;
  final int id;
  final WithdrawalFeeRepository _service;

  final formKey = GlobalKey<FormState>();
  final percentController = TextEditingController();
  final fixedController = TextEditingController();
  final minimumController = TextEditingController();

  WithdrawalFeeEditController(
    @factoryParam this.ruleId,
    @factoryParam this.id,
    this._service,
  ) : super(AsyncState.loading()) {
    _load();
  }

  Future<void> _load() async {
    setLoading(value);
    if (id == 0) {
      final initial = InitialUtils.getWithdrawalFee(ruleId: ruleId);
      _refreshControllers(initial);
      setValue(initial);
      return;
    }
    final result = await _service.retrieve(id);
    result.fold((error) => setError(error), (fee) {
      _refreshControllers(fee);
      setValue(fee);
    });
  }

  void _refreshControllers(WithdrawalFee fee) {
    percentController.text = fee.percent.toString();
    fixedController.text = fee.fixed.toStringAsFixed(2);
    minimumController.text = fee.minimum.toStringAsFixed(2);
  }

  Future<(bool, String?)> submit() async {
    if (value case AsyncData(value: final withdrawal)) {
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

      final feeToSave = withdrawal.copyWith(
        percent: double.parse(percentController.text.trim()),
        fixed: double.parse(fixedController.text.trim()),
        minimum: double.parse(minimumController.text.trim()),
      );

      setLoading(value);

      final result = await _service.save(feeToSave);

      return result.fold(
        (error) {
          setValue(feeToSave);
          return (false, error);
        },
        (fee) {
          setValue(fee);
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }
}

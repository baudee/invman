import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@Riverpod(keepAlive: true)
class WithdrawalFeeForm extends _$WithdrawalFeeForm {
  @override
  ModelState<WithdrawalFee> build(int ruleId, int id) {
    Future.microtask(() => load());
    return Loading();
  }

  final formKey = GlobalKey<FormState>();

  final percentController = TextEditingController();
  final fixedController = TextEditingController();
  final minimumController = TextEditingController();

  void _refreshControllers() {
    if (state case Success<WithdrawalFee>(data: final fee)) {
      percentController.text = fee.percent.toString();
      fixedController.text = (fee.fixed / 100).toStringAsFixed(0);
      minimumController.text = (fee.minimum / 100).toStringAsFixed(0);
    }
  }

  Future<void> load() async {
    state = Loading();

    if (id == 0) {
      state = Success(InitialUtils.getWithdrawalFee(ruleId: ruleId));
      _refreshControllers();
      return;
    }

    final result = await ref.read(withdrawalFeeServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (withdrawal) {
      state = Success(withdrawal);
      _refreshControllers();
    });
  }

  Future<(bool, String?)> submit() async {
    if (state case Success<WithdrawalFee>(data: final withdrawal)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (double.tryParse(percentController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidPercentage);
      }

      if (int.tryParse(fixedController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidFixed);
      }

      if (int.tryParse(minimumController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidMinimum);
      }

      final ruleToSave = withdrawal.copyWith(
        percent: double.parse(percentController.text.trim()),
        fixed: int.parse(fixedController.text.trim()) * 100,
        minimum: int.parse(minimumController.text.trim()) * 100,
      );

      state = Loading();

      final result = await ref.read(withdrawalFeeServiceProvider).save(ruleToSave);

      return result.fold((error) {
        state = Success(ruleToSave);
        return (false, error);
      }, (fee) {
        state = Success(fee);
        if (fee.id != null) {
          ref.invalidate(withdrawalFeeDetailProvider(fee.id!));
        }
        ref.invalidate(withdrawalRuleDetailProvider(fee.ruleId));
        return (true, S.current.core_itemSaved);
      });
    }
    return (false, S.current.error_invalidState);
  }

  Future<(bool, String?)> delete() async {
    if (state is! Success) {
      return (false, S.current.error_invalidState);
    }

    final feeToDelete = (state as Success).data;

    state = Loading();

    final result = await ref.read(withdrawalFeeServiceProvider).delete(id);

    return result.fold((error) {
      state = Success(feeToDelete);
      return (false, error);
    }, (deletedWithdrawalFee) {
      state = Success(deletedWithdrawalFee);
      ref.invalidate(withdrawalRuleDetailProvider(deletedWithdrawalFee.ruleId));
      return (true, S.current.core_itemDeleted);
    });
  }
}

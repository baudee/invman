import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@Riverpod(keepAlive: true)
class WithdrawalForm extends _$WithdrawalForm {
  @override
  ModelState<Withdrawal> build(int id) {
    Future.microtask(() => load());
    return Loading();
  }

  final formKey = GlobalKey<FormState>();

  final percentController = TextEditingController();
  final fixedController = TextEditingController();
  final minimumController = TextEditingController();

  void _refreshControllers() {
    if (state case Success<Withdrawal>(data: final withdrawal)) {
      percentController.text = withdrawal.percent.toString();
      fixedController.text = (withdrawal.fixed / 100).toStringAsFixed(0);
      minimumController.text = (withdrawal.minimum / 100).toStringAsFixed(0);
    }
  }

  Future<void> load() async {
    state = Loading();

    if (id == 0) {
      state = Success(InitialUtils.getWithdrawal());
      _refreshControllers();
      return;
    }

    final result = await ref.read(withdrawalServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (withdrawal) {
      state = Success(withdrawal);
      _refreshControllers();
    });
  }

  Future<(bool, String?)> submit() async {
    if (state case Success<Withdrawal>(data: final withdrawal)) {
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

      final withdrawalToSave = withdrawal.copyWith(
        percent: double.parse(percentController.text.trim()),
        fixed: int.parse(fixedController.text.trim()) * 100,
        minimum: int.parse(minimumController.text.trim()) * 100,
      );

      state = Loading();

      final result = await ref.read(withdrawalServiceProvider).save(withdrawalToSave);

      return result.fold((error) {
        state = Success(withdrawalToSave);
        return (false, error);
      }, (t) {
        state = Success(t);
        ref.read(withdrawalListProvider.notifier).refresh();
        if (t.id != null) {
          ref.invalidate(withdrawalDetailProvider(t.id!));
        }
        return (true, S.current.core_itemSaved);
      });
    }
    return (false, S.current.error_invalidState);
  }
}

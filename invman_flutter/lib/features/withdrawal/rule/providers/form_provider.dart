import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@Riverpod(keepAlive: true)
class WithdrawalRuleForm extends _$WithdrawalRuleForm {
  @override
  ModelState<WithdrawalRule> build(int id) {
    Future.microtask(() => load());
    return Loading();
  }

  final formKey = GlobalKey<FormState>();

  final currencyChangePercentageController = TextEditingController();
  final nameController = TextEditingController();

  void _refreshControllers() {
    if (state case Success<WithdrawalRule>(data: final rule)) {
      currencyChangePercentageController.text = rule.currencyChangePercentage.toString();
      nameController.text = rule.name;
    }
  }

  Future<void> load() async {
    state = Loading();

    if (id == 0) {
      state = Success(InitialUtils.getWithdrawalRule());
      _refreshControllers();
      return;
    }

    final result = await ref.read(withdrawalRuleServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (rule) {
      state = Success(rule);
      _refreshControllers();
    });
  }

  Future<(bool, String?)> submit() async {
    if (state case Success<WithdrawalRule>(data: final withdrawal)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (double.tryParse(currencyChangePercentageController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidPercentage);
      }

      final withdrawalToSave = withdrawal.copyWith(
        name: nameController.text.trim(),
        currencyChangePercentage: double.parse(currencyChangePercentageController.text.trim()),
      );

      state = Loading();

      final result = await ref.read(withdrawalRuleServiceProvider).save(withdrawalToSave);

      return result.fold((error) {
        state = Success(withdrawalToSave);
        return (false, error);
      }, (t) {
        state = Success(t);
        ref.read(withdrawalRuleListProvider.notifier).refresh();
        if (t.id != null) {
          ref.invalidate(withdrawalRuleDetailProvider(t.id!));
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

    final ruleToDelete = (state as Success).data;

    state = Loading();

    final result = await ref.read(withdrawalRuleServiceProvider).delete(id);

    return result.fold((error) {
      state = Success(ruleToDelete);
      return (false, error);
    }, (deletedWithdrawalRule) {
      state = Success(deletedWithdrawalRule);
      ref.read(withdrawalRuleListProvider.notifier).refresh();
      return (true, S.current.core_itemDeleted);
    });
  }
}

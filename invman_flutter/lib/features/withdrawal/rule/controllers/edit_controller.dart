import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/services/withdrawal_rule_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalRuleEditController extends AsyncSignal<WithdrawalRule> {
  final int id;
  final WithdrawalRuleService _service;

  final formKey = GlobalKey<FormState>();
  final currencyChangePercentageController = TextEditingController();
  final nameController = TextEditingController();

  WithdrawalRuleEditController(@factoryParam this.id, this._service) : super(AsyncState.loading()) {
    _load();
  }

  Future<void> _load() async {
    setLoading(value);
    if (id == 0) {
      final initial = InitialUtils.getWithdrawalRule();
      _refreshControllers(initial);
      setValue(initial);
    }
    final result = await _service.retrieve(id);
    result.fold((error) => setError(error), (rule) {
      _refreshControllers(rule);
      setValue(rule);
    });
  }

  void _refreshControllers(WithdrawalRule rule) {
    currencyChangePercentageController.text = rule.currencyChangePercentage.toString();
    nameController.text = rule.name;
  }

  Future<(bool, String?)> submit() async {
    if (value case AsyncData(value: final rule)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (double.tryParse(currencyChangePercentageController.text.trim()) == null) {
        return (false, S.current.withdrawal_selectValidPercentage);
      }

      final ruleToSave = rule.copyWith(
        currencyChangePercentage: double.parse(currencyChangePercentageController.text.trim()),
        name: nameController.text.trim(),
      );

      setLoading(value);

      final result = await _service.save(ruleToSave);

      return result.fold(
        (error) {
          setValue(ruleToSave);
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

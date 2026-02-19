import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/repositories/withdrawal_rule_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalRuleEditController extends AsyncSignal<WithdrawalRule> {
  final int id;
  final WithdrawalRuleRepository _repository;

  final formKey = GlobalKey<FormState>();
  final currencyChangePercentageController = TextEditingController();
  final nameController = TextEditingController();

  final Signal<List<WithdrawalFee>> fees = signal([]);

  // Fee editing state
  final feeFormKey = GlobalKey<FormState>();
  final feePercentController = TextEditingController();
  final feeFixedController = TextEditingController();
  final feeMinimumController = TextEditingController();
  int? _editingFeeIndex;

  bool get isEditingFee => _editingFeeIndex != null;

  WithdrawalRuleEditController(@factoryParam this.id, this._repository) : super(AsyncState.loading()) {
    _load();
  }

  Future<void> _load() async {
    setLoading(value);
    if (id == 0) {
      final initial = InitialUtils.getWithdrawalRule();
      _refreshControllers(initial);
      fees.value = [];
      setValue(initial);
    } else {
      final result = await _repository.retrieve(id);
      result.fold((error) => setError(error), (rule) {
        _refreshControllers(rule);
        fees.value = List.from(rule.fees ?? []);
        setValue(rule);
      });
    }
  }

  void _refreshControllers(WithdrawalRule rule) {
    currencyChangePercentageController.text = rule.currencyChangePercentage.toString();
    nameController.text = rule.name;
  }

  void initFeeForAdd() {
    _editingFeeIndex = null;
    feePercentController.text = '0.0';
    feeFixedController.text = '0.00';
    feeMinimumController.text = '0.00';
  }

  void initFeeForEdit(int index) {
    final fee = fees.value[index];
    _editingFeeIndex = index;
    feePercentController.text = fee.percent.toString();
    feeFixedController.text = fee.fixed.toStringAsFixed(2);
    feeMinimumController.text = fee.minimum.toStringAsFixed(2);
  }

  bool saveFee() {
    if (!feeFormKey.currentState!.validate()) return false;

    final percent = double.parse(feePercentController.text.trim());
    final fixed = double.parse(feeFixedController.text.trim());
    final minimum = double.parse(feeMinimumController.text.trim());

    if (_editingFeeIndex != null) {
      final updated = List<WithdrawalFee>.from(fees.value);
      updated[_editingFeeIndex!] = updated[_editingFeeIndex!].copyWith(
        percent: percent,
        fixed: fixed,
        minimum: minimum,
      );
      fees.value = updated;
    } else {
      fees.value = [...fees.value, WithdrawalFee(ruleId: id, percent: percent, fixed: fixed, minimum: minimum)];
    }
    return true;
  }

  void removeFee(int index) {
    final updated = List<WithdrawalFee>.from(fees.value);
    updated.removeAt(index);
    fees.value = updated;
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
        fees: fees.value,
      );

      setLoading(value);

      final result = await _repository.save(ruleToSave);

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

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentEditController extends AsyncSignal<Investment> {
  final int id;
  final InvestmentRepository _service;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  InvestmentEditController(@factoryParam this.id, this._service)
    : super(AsyncState.loading()) {
    _load();
  }

  Future<void> _load() async {
    setLoading(value);
    if (id == 0) {
      final initial = InitialUtils.getInvestment();
      _refreshControllers(initial);
      setValue(initial);
      return;
    }
    final result = await _service.retrieve(id);
    result.fold((error) => setError(error), (investment) {
      _refreshControllers(investment);
      setValue(investment);
    });
  }

  void _refreshControllers(Investment investment) {
    nameController.text = investment.name;
  }

  void setWithdrawalRule(WithdrawalRule rule) {
    if (value case AsyncData(value: final investment)) {
      setValue(
        investment.copyWith(withdrawalRule: rule, withdrawalRuleId: rule.id),
      );
    }
  }

  void setStock(Stock stock) {
    if (value case AsyncData(value: final investment)) {
      setValue(investment.copyWith(stock: stock));
    }
  }

  Future<(bool, String?)> submit() async {
    if (value case AsyncData(value: Investment investment)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (investment.withdrawalRuleId == 0) {
        return (false, S.current.error_selectWithdrawalRule);
      }

      if (investment.stock == null) {
        return (false, S.current.error_selectStock);
      }

      investment = investment.copyWith(name: nameController.text);

      setLoading(value);

      final result = await _service.save(investment);

      return result.fold(
        (error) {
          setValue(investment);
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

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/controllers/list_controller.dart';
import 'package:invman_flutter/features/investment/services/investment_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentFormController {
  final int id;
  final InvestmentService _service;
  final InvestmentListController _listController;

  late final AsyncSignal<Investment> state;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  InvestmentFormController(
    @factoryParam this.id,
    this._service,
    this._listController,
  ) {
    state = futureSignal(() => _loadInitial());
  }

  Future<Investment> _loadInitial() async {
    if (id == 0) {
      final initial = InitialUtils.getInvestment();
      _refreshControllers(initial);
      return initial;
    }
    final investment = await _service.retrieve(id);
    _refreshControllers(investment);
    return investment;
  }

  void _refreshControllers(Investment investment) {
    nameController.text = investment.name;
  }

  void setWithdrawalRule(WithdrawalRule rule) {
    if (state.value case AsyncData(value: final investment)) {
      state.value = AsyncData(investment.copyWith(withdrawalRule: rule, withdrawalRuleId: rule.id));
    }
  }

  void setStock(Stock stock) {
    if (state.value case AsyncData(value: final investment)) {
      state.value = AsyncData(investment.copyWith(stock: stock));
    }
  }

  Future<(bool, String?)> submit() async {
    if (state.value case AsyncData(value: Investment investment)) {
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

      state.value = AsyncLoading();

      final result = await _service.save(investment);

      return result.fold(
        (error) {
          state.value = AsyncData(investment);
          return (false, error);
        },
        (saved) {
          state.value = AsyncData(saved);
          _listController.refresh();
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  Future<(bool, String?)> delete() async {
    if (state.value case AsyncData(value: final investmentToDelete)) {
      state.value = AsyncLoading();

      final result = await _service.delete(id);

      return result.fold(
        (error) {
          state.value = AsyncData(investmentToDelete);
          return (false, error);
        },
        (deletedInvestment) {
          state.value = AsyncData(deletedInvestment);
          _listController.refresh();
          return (true, S.current.core_itemDeleted);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  void dispose() {
    nameController.dispose();
    state.dispose();
  }
}

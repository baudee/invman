import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@riverpod
class InvestmentForm extends _$InvestmentForm {
  @override
  ModelState<Investment> build(int id) {
    Future.microtask(() => load());
    return Loading();
  }

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  void _refreshControllers() {
    if (state case Success<Investment>(data: final investment)) {
      nameController.text = investment.name;
    }
  }

  void setWithdrawalRule(WithdrawalRule rule) {
    if (state case Success<Investment>(data: final investment)) {
      state = Success(investment.copyWith(withdrawalRule: rule, withdrawalRuleId: rule.id));
    }
  }

  void setStock(Stock stock) {
    if (state case Success<Investment>(data: final investment)) {
      state = Success(investment.copyWith(stockSymbol: stock.symbol, stock: stock));
    }
  }

  Future<void> load() async {
    state = Loading();

    if (id == 0) {
      state = Success(InitialUtils.getInvestment());
      _refreshControllers();
      return;
    }
    final currency = ref.read(userPreferencesProvider).currency;
    final result = await ref.read(investmentServiceProvider).retrieve(id, currency: currency);

    result.fold((error) {
      state = Failure(error);
    }, (investment) {
      state = Success(investment);
      _refreshControllers();
    });
  }

  Future<(bool, String?)> submit() async {
    if (state case Success<Investment>(data: Investment investment)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (investment.withdrawalRuleId == 0) {
        return (false, S.current.error_selectWithdrawalRule);
      }

      if (investment.stockSymbol.isEmpty) {
        return (false, S.current.error_selectStock);
      }

      investment = investment.copyWith(
        name: nameController.text,
      );

      state = Loading();

      final currency = ref.read(userPreferencesProvider).currency;
      final result = await ref.read(investmentServiceProvider).save(investment, currency: currency);

      return result.fold((error) {
        state = Success(investment);
        return (false, error);
      }, (t) {
        state = Success(t);
        ref.read(investmentListProvider.notifier).refresh();
        if (t.id != null) {
          ref.invalidate(investmentDetailProvider(t.id!));
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

    final investmentToDelete = (state as Success).data;

    state = Loading();

    final result = await ref.read(investmentServiceProvider).delete(id);

    return result.fold((error) {
      state = Success(investmentToDelete);
      return (false, error);
    }, (deletedInvestment) {
      state = Success(deletedInvestment);
      ref.read(investmentListProvider.notifier).refresh();
      return (true, S.current.core_itemDeleted);
    });
  }
}

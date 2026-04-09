import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentEditController extends Disposable {
  final int id;
  final InvestmentRepository _repository;

  final _state = asyncSignal<Investment>(AsyncState.loading());
  ReadonlySignal<AsyncState<Investment>> get state => _state;

  final FlutterSignal<int?> _investmentsCount = signal<int?>(null);
  ReadonlySignal<int?> get investmentsCount => _investmentsCount;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  InvestmentEditController(@factoryParam this.id, this._repository) {
    _load();
  }

  Future<void> _load() async {
    _state.value = AsyncState.loading();
    if (id == 0) {
      final initial = InitialUtils.getInvestment();
      _refreshControllers(initial);
      _state.value = AsyncState.data(initial);
      return;
    }
    final result = await _repository.retrieve(id);
    result.fold((error) => _state.value = AsyncState.error(error), (investment) {
      _refreshControllers(investment);
      _state.value = AsyncState.data(investment);
    });
  }

  void _refreshControllers(Investment investment) {
    nameController.text = investment.name;
  }

  void setWithdrawalRule(WithdrawalRule rule) {
    if (_state.value case AsyncData(value: final investment)) {
      _state.value = AsyncState.data(investment.copyWith(withdrawalRule: rule, withdrawalRuleId: rule.id));
    }
  }

  void setAsset(Asset asset) {
    if (_state.value case AsyncData(value: final investment)) {
      _state.value = AsyncState.data(investment.copyWith(asset: asset, assetId: asset.id));
    }
  }

  Future<(bool, String?)> submit() async {
    if (_state.value case AsyncData(value: Investment investment)) {
      if (!formKey.currentState!.validate()) {
        return (false, S.current.error_fixToContinue);
      }

      if (investment.assetId == UuidValue.fromString(Namespace.nil.value)) {
        return (false, S.current.error_selectAsset);
      }

      investment = investment.copyWith(name: nameController.text);

      _state.value = AsyncState.loading();

      final result = await _repository.save(investment);

      return result.fold(
        (error) {
          _state.value = AsyncState.data(investment);
          return (false, error);
        },
        (saved) {
          _state.value = AsyncState.data(saved);
          return (true, S.current.core_itemSaved);
        },
      );
    }
    return (false, S.current.error_invalidState);
  }

  Future<void> reload() => _load();

  @override
  FutureOr<dynamic> onDispose() {
    _state.dispose();
  }
}

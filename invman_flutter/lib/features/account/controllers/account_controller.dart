import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/repositories/repositories.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class AccountController implements Disposable {
  final AccountRepository _accountRepository;
  final CurrencyRepository _currencyRepository;
  final InvestmentRepository _investmentRepository;
  final AuthManager _authManager;

  AccountController(this._accountRepository, this._currencyRepository, this._investmentRepository, this._authManager) {
    _load();
  }

  final _state = asyncSignal<List<Currency>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Currency>>> get state => _state;
  final _selectedCurrency = signal<Currency?>(null);
  ReadonlySignal<Currency?> get selectedCurrency => _selectedCurrency;

  Future<void> _load() async {
    _state.value = AsyncState.loading();
    final result = await _currencyRepository.list();
    result.fold(
      (error) => _state.value = AsyncState.error(error),
      (currencies) {
        _state.value = AsyncState.data(currencies);
        _selectedCurrency.value = currencies.where((c) => c.code == _authManager.currencyCode).firstOrNull;
      },
    );
  }

  Future<String?> changeCurrency(Currency currency) async {
    if (currency.id == _authManager.currency?.id) {
      return null;
    }
    final oldCurrency = _authManager.currency;
    _selectedCurrency.value = null;

    final account = _authManager.account.value;
    if (account == null) {
      return S.current.error_code(ErrorCode.badRequest);
    }
    final newAccount = account.copyWith(currencyId: currency.id, currency: currency);
    final result = await _accountRepository.save(newAccount);
    return result.fold(
      (error) {
        _selectedCurrency.value = oldCurrency;
        return error;
      },
      (_) {
        _selectedCurrency.value = currency;
        _authManager.replaceMe(newAccount);
        _investmentRepository.invalidate();
        return null;
      },
    );
  }

  @override
  FutureOr<dynamic> onDispose() {
    _state.dispose();
  }
}

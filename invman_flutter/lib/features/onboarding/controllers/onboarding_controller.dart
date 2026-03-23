import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class OnboardingController implements Disposable {
  final AuthManager _authManager;
  final AccountRepository _accountRepository;
  final CurrencyRepository _currencyRepository;

  final _state = asyncSignal<List<Currency>>(AsyncState.loading());
  ReadonlySignal<AsyncState<List<Currency>>> get state => _state;

  late final Signal<int?> _selectedCurrency = signal(null);
  ReadonlySignal<int?> get selectedCurrency => _selectedCurrency;
  late final Signal<bool> _isValidating = signal(false);
  ReadonlySignal<bool> get isValidating => _isValidating;

  OnboardingController(this._authManager, this._accountRepository, this._currencyRepository) {
    _load();
  }

  Future<void> _load() async {
    _state.value = AsyncState.loading();
    final result = await _currencyRepository.list();
    result.fold(
      (error) => _state.value = AsyncState.error(error),
      (currencies) => _state.value = AsyncState.data(currencies),
    );
  }

  Future<String?> validateCurrency() async {
    if (_selectedCurrency.value == null) {
      return S.current.onboarding_select_currency;
    }
    _isValidating.value = true;
    try {
      final account = Account(userId: UuidValue.fromString(Namespace.nil.value), currencyId: _selectedCurrency.value!);
      await _accountRepository.save(account.copyWith(currencyId: _selectedCurrency.value));
      await _authManager.refreshMe();
      _isValidating.value = false;
      return null;
    } on Exception catch (e) {
      _isValidating.value = false;
      return e.toString();
    }
  }

  void selectCurrency(int? currencyId) {
    _selectedCurrency.value = currencyId;
  }

  Future<void> reload() => _load();

  @override
  FutureOr<dynamic> onDispose() {
    _state.dispose();
    _selectedCurrency.dispose();
    _isValidating.dispose();
  }
}

import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class OnboardingController {
  final AuthController _authController;

  final AccountService _accountService;
  final CurrencyService _currencyService;

  late final FutureSignal<List<Currency>> currencies;
  late final Signal<int?> selectedCurrency = signal(null);
  late final Signal<bool> isValidating = signal(false);

  OnboardingController(this._authController, this._accountService, this._currencyService) {
    currencies = FutureSignal(() => _currencyService.list());
  }

  Future<String?> validateCurrency() async {
    if (selectedCurrency.value == null) {
      return S.current.onboarding_select_currency;
    }
    isValidating.value = true;
    try {
      final account = Account(userId: UuidValue.fromString(Namespace.nil.value), currencyId: selectedCurrency.value!);
      await _accountService.save(account.copyWith(currencyId: selectedCurrency.value));
      await _authController.refreshMe();
      isValidating.value = false;
      return null;
    } on Exception catch (e) {
      isValidating.value = false;
      return e.toString();
    }
  }

  void selectCurrency(int? currencyId) {
    selectedCurrency.value = currencyId;
  }
}

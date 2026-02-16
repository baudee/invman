import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class OnboardingController extends AsyncSignal<List<Currency>> {
  final AuthManager _authService;
  final AccountRepository _accountService;
  final CurrencyRepository _currencyService;

  late final Signal<int?> selectedCurrency = signal(null);
  late final Signal<bool> isValidating = signal(false);

  OnboardingController(
    this._authService,
    this._accountService,
    this._currencyService,
  ) : super(AsyncState.loading()) {
    setLoading();
    _currencyService.list().then((result) {
      result.fold(
        (error) => setError(error),
        (currencies) => setValue(currencies),
      );
    });
  }

  Future<String?> validateCurrency() async {
    if (selectedCurrency.value == null) {
      return S.current.onboarding_select_currency;
    }
    isValidating.value = true;
    try {
      final account = Account(
        userId: UuidValue.fromString(Namespace.nil.value),
        currencyId: selectedCurrency.value!,
      );
      await _accountService.save(
        account.copyWith(currencyId: selectedCurrency.value),
      );
      await _authService.refreshMe();
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

import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/repositories/user_preferences_repository.dart';
import 'package:invman_flutter/env.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthManager {
  final AccountRepository _accountService;
  final UserPreferencesRepository _preferencesRepository;
  final Client _client;

  final FlutterSignal<AuthState> _state = signal<AuthState>(AuthStateBooting());
  ReadonlySignal<AuthState> get state => _state;
  late final FlutterComputed<bool> _isLoggedIn = computed(
    () => _state.value is AuthStateSuccess || _state.value is AuthStateOnboarding,
  );
  ReadonlySignal<bool> get isLoggedIn => _isLoggedIn;
  late final FlutterComputed<bool> _isOnboarded = computed(
    () => _state.value is! AuthStateOnboarding && _state.value is AuthStateSuccess,
  );
  ReadonlySignal<bool> get isOnboarded => _isOnboarded;
  late final FlutterComputed<Account?> _account = computed(() {
    final currentState = _state.value;
    if (currentState case AuthStateSuccess(:final account)) {
      return account;
    } else if (currentState case AuthStateOnboarding(:final account)) {
      return account;
    }
    return null;
  });
  ReadonlySignal<Account?> get account => _account;

  AuthManager({
    required AccountRepository accountService,
    required UserPreferencesRepository preferencesRepository,
    required Client client,
    required Env env,
  }) : _accountService = accountService,
       _preferencesRepository = preferencesRepository,
       _client = client;

  Future<void> init() async {
    _state.value = AuthStateBooting();
    await _client.auth.initialize();

    _client.auth.authInfoListenable.addListener(() async {
      if (!_client.auth.isAuthenticated) {
        resetState();
      } else {
        final accountResult = await _accountService.retrieve();
        accountResult.fold(
          (error) {
            resetState();
          },
          (account) {
            _setAccount();
          },
        );
      }
    });

    await refreshMe();
  }

  Future<String?> refreshMe() async {
    final userInfo = _client.auth.authInfo;

    if (userInfo == null) {
      resetState();
      return null;
    }

    return _setAccount();
  }

  Future<String?> _setAccount() async {
    final accountResult = await _accountService.retrieve();

    return accountResult.fold(
      (error) {
        resetState();
        return error;
      },
      (account) {
        if (account.isOnboarded()) {
          _state.value = AuthStateSuccess(account: account);
        } else {
          _state.value = AuthStateOnboarding(account: account);
        }
        return null;
      },
    );
  }

  Future<String?> logout() async {
    if (_state.value is! AuthStateSuccess) {
      return S.current.error_invalidState;
    }

    try {
      await _client.auth.signOutDevice();
      resetState();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void setCredentialsInState(String email, String password) {
    _state.value = AuthStateGuest(email: email, password: password);
  }

  void resetState() {
    final email = _preferencesRepository.getEmail() ?? "";
    _state.value = AuthStateGuest(email: email);
  }

  void replaceMe(Account account) {
    if (_state.value case AuthStateSuccess()) {
      _state.value = AuthStateSuccess(account: account);
    }
  }
}

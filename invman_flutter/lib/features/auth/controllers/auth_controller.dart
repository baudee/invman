import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/services/services.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

@singleton
class AuthController {
  final AccountService _accountService;
  final StorageClient _storage;
  final Client _client;

  final FlutterSignal<AuthState> state = signal<AuthState>(AuthStateBooting());
  late final FlutterComputed<bool> isLoggedIn = computed(
    () => state.value is AuthStateSuccess || state.value is AuthStateOnboarding,
  );
  late final FlutterComputed<bool> isOnboarded = computed(
    () => state.value is! AuthStateOnboarding && state.value is AuthStateSuccess,
  );

  AuthController({required AccountService accountService, required StorageClient storage, required Client client})
    : _accountService = accountService,
      _storage = storage,
      _client = client;

  Future<void> init() async {
    state.value = AuthStateBooting();
    await _client.auth.initialize();

    _client.auth.authInfoListenable.addListener(() async {
      if (!_client.auth.isAuthenticated) {
        resetState();
      } else {
        _accountService.retrieve().ca
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
    final userInfoResult = await _client.auth.authInfo;

    return userInfoResult.fold(
      (error) {
        resetState();
        return error;
      },
      (userInfo) {
        return _setAccount();
      },
    );
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
          state.value = AuthStateSuccess(account: account);
        } else {
          state.value = AuthStateOnboarding(account: account);
        }
        return null;
      },
    );
  }

  Future<String?> logout() async {
    if (state.value is! AuthStateSuccess) {
      return S.current.error_invalidState;
    }

    final result = await _authService.logout();

    return result.fold(
      (error) {
        return error;
      },
      (_) {
        resetState();
        return null;
      },
    );
  }

  void setCredentialsInState(String email, String password) {
    state.value = AuthStateGuest(email: email, password: password);
  }

  void resetState() {
    final email = _storage.getString(StorageClient.emailKey);
    state.value = AuthStateGuest(email: email);
  }

  void saveEmail(String email) {
    _storage.setString(StorageClient.emailKey, email);
  }
}

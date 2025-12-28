import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthStateBooting();
  }

  Future<void> init() async {
    state = AuthStateBooting();
    final client = ref.read(clientProvider);
    await client.auth.initialize();

    client.auth.authInfoListenable.addListener(() {
      if (!client.auth.isAuthenticated) {
        resetState();
      } else {
        state = AuthStateSuccess();
      }
    });

    await refreshMe();
  }

  Future<String?> refreshMe() async {
    final userInfoResult = await ref.read(authServiceProvider).currentUser();

    return userInfoResult.fold(
      (error) {
        resetState();
        return error;
      },
      (userInfo) async {
        if (userInfo == null) {
          resetState();
        } else {
          state = AuthStateSuccess();
        }
      },
    );
  }

  Future<void> replaceMe() async {
    state = AuthStateSuccess();
  }

  Future<String?> logout() async {
    if (state is! AuthStateSuccess) {
      return S.current.error_invalidState;
    }

    final result = await ref.read(authServiceProvider).logout();

    return result.fold(
      (error) {
        state = AuthStateSuccess();
        return error;
      },
      (_) {
        resetState();
        return null;
      },
    );
  }

  void setCredentialsInState(String email, String password) {
    state = AuthStateGuest(email: email, password: password);
  }

  void resetState() {
    final email = ref.read(storageProvider).getString(StorageClient.emailKey);
    state = AuthStateGuest(email: email);
  }

  void saveEmail(String email) {
    ref.read(storageProvider).setString(StorageClient.emailKey, email);
  }
}

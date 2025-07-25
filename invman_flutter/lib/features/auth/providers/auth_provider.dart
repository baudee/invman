import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/core/providers/session_manager_provider.dart';
import 'package:invman_flutter/features/auth/auth.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthStateBooting();
  }

  Future<void> init() async {
    final provider = ref.read(sessionManagerProvider);
    await provider.initialize();

    provider.addListener(() {
      if (!provider.isSignedIn) {
        resetState();
      }
    });

    await refreshMe();
  }

  Future<String?> refreshMe() async {
    final userInfoResult = ref.read(authServiceProvider).currentUser();

    return userInfoResult.fold((error) {
      resetState();
      return error;
    }, (userInfo) async {
      if (userInfo == null) {
        resetState();
      } else {
        state = AuthStateSuccess();
      }
      return null;
    });
  }

  Future<void> replaceMe() async {
    state = AuthStateSuccess();
  }

  Future<String?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    state = AuthStateLoading();

    final result = await ref.read(authServiceProvider).loginWithEmail(email: email, password: password);

    return result.fold((error) {
      state = AuthStateGuest(email: email, password: password);
      return error;
    }, (userInfo) async {
      saveEmail(email);
      state = AuthStateSuccess();
      return null;
    });
  }

  Future<String?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    state = AuthStateLoading();

    final (isEmailValid, message) = await checkEmail(email);
    if (!isEmailValid) {
      state = AuthStateGuest(email: email, password: password);
      return message;
    }

    final result = await ref.read(authServiceProvider).registerWithEmail(
          email: email,
          password: password,
        );

    return result.fold((error) {
      state = AuthStateGuest(email: email, password: password);
      return error;
    }, (_) async {
      state = AuthStateVerificationCodeRequired(email: email, password: password);
      return null;
    });
  }

  Future<String?> confirmEmailRegister({
    required String email,
    required String password,
    required String verificationCode,
  }) async {
    state = AuthStateLoading();

    final result = await ref.read(authServiceProvider).confirmEmailRegister(
          email: email,
          password: password,
          verificationCode: verificationCode,
        );

    return result.fold((error) {
      state = AuthStateVerificationCodeRequired(email: email, password: password);
      return error;
    }, (_) async {
      saveEmail(email);
      state = AuthStateSuccess();
      return null;
    });
  }

  Future<String?> initiatePasswordReset(String email) async {
    state = AuthStateLoading();

    final result = await ref.read(authServiceProvider).initiatePasswordReset(email);

    return result.fold((error) {
      state = AuthStateGuest(email: email);
      return error;
    }, (_) {
      state = AuthStatePasswordResetCodeRequired(email: email);
      return null;
    });
  }

  Future<String?> completePasswordReset(String verificationCode, String newPassword, String email) async {
    state = AuthStateLoading();

    final result = await ref.read(authServiceProvider).completePasswordReset(verificationCode, newPassword, email);

    return result.fold((error) {
      state = AuthStatePasswordResetCodeRequired(email: email);
      return error;
    }, (_) async {
      state = AuthStateSuccess();
      return null;
    });
  }

  Future<String?> logout() async {
    if (state is! AuthStateSuccess) {
      return S.current.error_invalidState;
    }

    state = AuthStateLoading();

    final result = await ref.read(authServiceProvider).logout();

    return result.fold((error) {
      state = AuthStateSuccess();
      return error;
    }, (_) {
      resetState();
      return null;
    });
  }

  Future<(bool, String?)> checkEmail(String email) async {
    final result = await ref.read(authServiceProvider).emailIsAvailable(email);
    return result.fold((error) {
      return (false, error);
    }, (emailAvailable) {
      String? message = emailAvailable ? null : S.current.error_emailNotAvailable;
      return (emailAvailable, message);
    });
  }

  void setCredentialsInState(String email, String password) {
    state = AuthStateGuest(
      email: email,
      password: password,
    );
  }

  void resetState() {
    final email = ref.read(storageProvider).getString(StorageClient.emailKey);
    state = AuthStateGuest(
      email: email,
    );
  }

  void saveEmail(String email) {
    ref.read(storageProvider).setString(StorageClient.emailKey, email);
  }
}

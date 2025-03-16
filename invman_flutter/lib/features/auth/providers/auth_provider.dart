// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
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
    await ref.read(sessionManagerProvider).initialize();
    await refreshMe();
  }

  Future<void> refreshMe() async {
    final userInfoResult = ref.read(authServiceProvider).currentUser();

    userInfoResult.fold((error) {
      state = AuthStateError(error: error);
    }, (userInfo) async {
      if (userInfo == null) {
        state = AuthStateGuest();
      }
    });
  }

  Future<void> replaceMe() async {
    state = AuthStateSuccess();
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    state = AuthStateGuest(isLoading: true);

    final result = await ref
        .read(authServiceProvider)
        .loginWithEmail(email: email, password: password);

    result.fold((error) {
      state = AuthStateGuest(error: error);
    }, (userInfo) async {
      state = AuthStateSuccess();
    });
  }

  Future<void> registerWithEmail({
    required String email,
    required String password,
  }) async {
    state = AuthStateGuest(isLoading: true);

    final isEmailValid = await checkEmail(email);
    if (!isEmailValid) {
      return;
    }

    final result = await ref.read(authServiceProvider).registerWithEmail(
          email: email,
          password: password,
        );

    result.fold((error) {
      state = AuthStateGuest(error: error);
    }, (_) async {
      state =
          AuthStateVerificationCodeRequired(email: email, password: password);
    });
  }

  Future<void> confirmEmailRegister({
    required String email,
    required String password,
    required String verificationCode,
  }) async {
    state = AuthStateVerificationCodeRequired(
        email: email, password: password, isLoading: true);

    final result = await ref.read(authServiceProvider).confirmEmailRegister(
          email: email,
          password: password,
          verificationCode: verificationCode,
        );

    result.fold((error) {
      state = AuthStateVerificationCodeRequired(
          email: email, password: password, error: error);
    }, (_) async {
      state = AuthStateSuccess();
    });
  }

  Future<void> initiatePasswordReset(String email) async {
    state = AuthStateGuest(isLoading: true);

    final result =
        await ref.read(authServiceProvider).initiatePasswordReset(email);

    result.fold((error) {
      state = AuthStateGuest(error: error);
    }, (_) {
      state = AuthStatePasswordResetCodeRequired(email: email);
    });
  }

  Future<void> completePasswordReset(
      String verificationCode, String newPassword, String email) async {
    state = AuthStatePasswordResetCodeRequired(email: email, isLoading: true);

    final result = await ref
        .read(authServiceProvider)
        .completePasswordReset(verificationCode, newPassword, email);

    result.fold((error) {
      state = AuthStatePasswordResetCodeRequired(email: email, error: error);
    }, (_) async {
      state = AuthStateSuccess();
    });
  }

  Future<void> logout() async {
    final result = await ref.read(authServiceProvider).logout();

    result.fold((error) {
      state = AuthStateGuest(error: error);
    }, (_) {
      state = AuthStateGuest();
    });
  }

  Future<bool> checkEmail(String email) async {
    final emailAvailable =
        await ref.read(authServiceProvider).emailIsAvailable(email);
    if (!emailAvailable) {
      state = AuthStateGuest(error: "Email not available!");
    }
    return emailAvailable;
  }

  Future<void> clearError() async {
    if (state is AuthStateGuest) {
      state = AuthStateGuest();
    }
  }
}

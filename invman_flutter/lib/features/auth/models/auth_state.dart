import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthStateBooting extends AuthState {}

final class AuthStateGuest extends AuthState {
  final bool isLoading;
  final String? error;

  const AuthStateGuest({this.isLoading = false, this.error});
}

final class AuthStateLoading extends AuthState {}

final class AuthStateVerificationCodeRequired extends AuthState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;

  const AuthStateVerificationCodeRequired({
    required this.email,
    required this.password,
    this.isLoading = false,
    this.error,
  });
}

final class AuthStatePasswordResetCodeRequired extends AuthState {
  final String email;
  final String? error;
  final bool isLoading;

  const AuthStatePasswordResetCodeRequired({required this.email, this.isLoading = false, this.error});
}

final class AuthStateSuccess extends AuthState {
  const AuthStateSuccess();
}

import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthStateBooting extends AuthState {}

final class AuthStateLoading extends AuthState {}

final class AuthStateGuest extends AuthState {
  final String? email;
  final String? password;

  const AuthStateGuest({
    this.email,
    this.password,
  });
}

final class AuthStateVerificationCodeRequired extends AuthState {
  final String email;
  final String password;

  const AuthStateVerificationCodeRequired({
    required this.email,
    required this.password,
  });
}

final class AuthStatePasswordResetCodeRequired extends AuthState {
  final String email;

  const AuthStatePasswordResetCodeRequired({required this.email});
}

final class AuthStateSuccess extends AuthState {
  const AuthStateSuccess();
}

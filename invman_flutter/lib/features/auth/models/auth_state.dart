import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthStateBooting extends AuthState {}

final class AuthStateGuest extends AuthState {
  final String? email;
  final String? password;

  const AuthStateGuest({this.email, this.password});
}

final class AuthStateSuccess extends AuthState {
  const AuthStateSuccess();
}

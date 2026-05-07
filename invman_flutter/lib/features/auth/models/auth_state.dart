import 'package:invman_client/invman_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthStateBooting extends AuthState {
  const AuthStateBooting();
}

final class AuthStateGuest extends AuthState {
  final String? email;
  final String? password;

  const AuthStateGuest({this.email, this.password});
}

final class AuthStateOnboarding extends AuthState {
  final Account account;
  final AuthSuccess userInfo;
  const AuthStateOnboarding({required this.account, required this.userInfo});
}

final class AuthStateSuccess extends AuthState {
  final Account account;
  final AuthSuccess userInfo;
  const AuthStateSuccess({required this.account, required this.userInfo});
}

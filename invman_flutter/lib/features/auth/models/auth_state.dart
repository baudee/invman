import 'package:invman_client/invman_client.dart';

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
  const AuthStateOnboarding({required this.account});
}

final class AuthStateSuccess extends AuthState {
  final Account account;
  const AuthStateSuccess({required this.account});
}

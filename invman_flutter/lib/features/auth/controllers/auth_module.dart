import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/repositories/user_preferences_repository.dart';
import 'package:invman_flutter/env.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';

@module
abstract class AuthModule {
  @singleton
  @preResolve
  Future<AuthManager> authManager(
    AccountRepository accountRepository,
    UserPreferencesRepository preferencesRepository,
    Client client,
    Env env,
  ) async {
    final manager = AuthManager(
      accountService: accountRepository,
      preferencesRepository: preferencesRepository,
      client: client,
      env: env,
    );
    await manager.init();
    return manager;
  }
}

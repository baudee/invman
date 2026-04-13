import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:invman_flutter/env.dart';
import 'package:invman_flutter/features/auth/controllers/auth_manager.dart';
import 'package:invman_flutter/features/auth/models/auth_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

@singleton
class RevenueCatManager {
  final Env _env;
  final AuthManager _authManager;

  RevenueCatManager(this._env, this._authManager) {
    _init();
  }

  Future<void> _init() async {
    final apiKey = Platform.isIOS ? _env.iosRevenueCatApiKey : _env.androidRevenueCatApiKey;
    await Purchases.configure(PurchasesConfiguration(apiKey));

    _authManager.state.subscribe((state) {
      switch (state) {
        case AuthStateSuccess(:final account) || AuthStateOnboarding(:final account):
          Purchases.logIn(account.userId.toString()).ignore();
        case AuthStateGuest():
          Purchases.logOut().ignore();
        default:
          break;
      }
    });
  }
}

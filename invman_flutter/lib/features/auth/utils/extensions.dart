import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/auth/auth.dart';

extension AuthExtensions on AuthManager {
  String get currencyCode => account.value?.currency?.code ?? "-";
  Currency? get currency => account.value?.currency;
  UserPermissions? get permissions => account.value?.permissions;
  Set<String> get scopes {
    final currentState = state.value;
    if (currentState case AuthStateSuccess(:final userInfo)) {
      return userInfo.scopeNames;
    } else if (currentState case AuthStateOnboarding(:final userInfo)) {
      return userInfo.scopeNames;
    }
    return {};
  }
}

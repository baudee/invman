import 'package:invman_server/src/features/auth/auth.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

extension UserPermissionsExtensions on UserPermissions {
  static UserPermissions fromSession(Session session) {
    final scopes = session.authenticated?.scopes ?? {};
    if (scopes.contains(UserScope.premium)) {
      return UserPermissions(investmentsLimit: null);
    } else {
      return UserPermissions(investmentsLimit: 3);
    }
  }
}

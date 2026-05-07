import 'package:injectable/injectable.dart';
import 'package:invman_server/src/features/auth/models/user_scopes.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class RevenueCatService {
  static const _premiumEvents = {'INITIAL_PURCHASE', 'RENEWAL', 'PRODUCT_CHANGE', 'UNCANCELLATION'};
  static const _freeEvents = {'CANCELLATION', 'EXPIRATION', 'BILLING_ISSUE'};

  Future<void> handleWebhook(Session session, Map<String, dynamic> payload) async {
    final event = payload['event'] as Map<String, dynamic>?;
    if (event == null) throw ServerException(errorCode: ErrorCode.badRequest);

    final eventType = event['type'] as String?;
    final appUserId = event['app_user_id'] as String?;

    if (eventType == null || appUserId == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    final bool grantPremium;
    if (_premiumEvents.contains(eventType)) {
      grantPremium = true;
    } else if (_freeEvents.contains(eventType)) {
      grantPremium = false;
    } else {
      return;
    }

    final authUserId = UuidValue.fromString(appUserId);
    final authUsers = AuthServices.instance.authUsers;

    try {
      await session.db.transaction((transaction) async {
        final authUser = await authUsers.get(
          session,
          authUserId: authUserId,
          transaction: transaction,
        );

        final updatedScopes = {...authUser.scopes};
        if (grantPremium) {
          updatedScopes.add(UserScope.premium);
        } else {
          updatedScopes.remove(UserScope.premium);
        }

        await authUsers.update(
          session,
          authUserId: authUserId,
          scopes: updatedScopes,
          transaction: transaction,
        );
      });

      await session.messages.authenticationRevoked(
        appUserId,
        RevokedAuthenticationUser(),
      );
    } on AuthUserNotFoundException {
      return;
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

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

    final SubscriptionPlan newPlan;
    if (_premiumEvents.contains(eventType)) {
      newPlan = SubscriptionPlan.premium;
    } else if (_freeEvents.contains(eventType)) {
      newPlan = SubscriptionPlan.free;
    } else {
      return;
    }

    final authUserId = UuidValue.fromString(appUserId);

    await session.db.transaction((transaction) async {
      final account = await Account.db.findFirstRow(
        session,
        where: (a) => a.userId.equals(authUserId),
        transaction: transaction,
      );

      if (account == null) return;
      if (account.subscriptionPlan == newPlan) return;

      await Account.db.updateRow(
        session,
        account.copyWith(subscriptionPlan: newPlan),
        transaction: transaction,
      );
    });
  }
}

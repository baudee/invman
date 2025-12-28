import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class WithdrawalRuleService {
  WithdrawalRuleService();

  Future<WithdrawalRuleList> list(Session session, {int limit = 10, int page = 1}) async {
    final sessionUserId = (session.authenticated)!.authUserId;
    final count = await WithdrawalRule.db.count(session, where: (e) => e.userId.equals(sessionUserId));

    final results = await WithdrawalRule.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      limit: limit,
      offset: (page * limit) - limit,
    );

    return WithdrawalRuleList(
      count: count,
      limit: limit,
      page: page,
      results: results,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }

  Future<WithdrawalRule> retrieve(Session session, int id, {Transaction? transaction}) async {
    final withdrawal = await WithdrawalRule.db.findById(
      session,
      id,
      include: IncludeHelpers.withdrawalInclude(),
      transaction: transaction,
    );

    if (withdrawal == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final sessionUser = session.authenticated;
    if (withdrawal.userId != sessionUser!.authUserId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return withdrawal;
  }

  Future<WithdrawalRule> save(Session session, WithdrawalRule withdrawal) async {
    if (withdrawal.id == 0 || withdrawal.id == null) {
      final sessionUserId = (session.authenticated)!.authUserId;
      withdrawal = withdrawal.copyWith(id: null, userId: sessionUserId);
      return WithdrawalRule.db.insertRow(session, withdrawal);
    } else {
      await retrieve(session, withdrawal.id!);
      return WithdrawalRule.db.updateRow(session, withdrawal);
    }
  }

  Future<WithdrawalRule> delete(Session session, int id) async {
    final withdrawal = await retrieve(session, id);
    return WithdrawalRule.db.deleteRow(session, withdrawal);
  }
}

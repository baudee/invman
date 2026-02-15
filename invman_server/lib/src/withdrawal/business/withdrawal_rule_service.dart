import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class WithdrawalRuleService {
  WithdrawalRuleService();

  Future<List<WithdrawalRule>> list(Session session, {required int limit, required int page}) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    return WithdrawalRule.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      limit: limit,
      offset: (page * limit) - limit,
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

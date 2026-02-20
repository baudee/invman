import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class WithdrawalRuleService {
  WithdrawalRuleService();

  Future<List<WithdrawalRule>> list(
    Session session, {
    required int limit,
    required int page,
  }) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    return WithdrawalRule.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.withdrawalInclude(),
      limit: limit,
      offset: (page * limit) - limit,
    );
  }

  Future<WithdrawalRule> retrieve(
    Session session,
    int id, {
    Transaction? transaction,
  }) async {
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

  Future<WithdrawalRule> save(
    Session session,
    WithdrawalRule withdrawal,
  ) async {
    return session.db.transaction(
      (transaction) async {
        final sessionUserId = (session.authenticated)!.authUserId;
        WithdrawalRule savedRule;

        if (withdrawal.id == 0 || withdrawal.id == null) {
          withdrawal = withdrawal.copyWith(id: null, userId: sessionUserId);
          savedRule = await WithdrawalRule.db.insertRow(
            session,
            withdrawal,
            transaction: transaction,
          );
        } else {
          await retrieve(session, withdrawal.id!, transaction: transaction);
          savedRule = await WithdrawalRule.db.updateRow(
            session,
            withdrawal,
            transaction: transaction,
          );
        }

        await _syncFees(
          session,
          rule: savedRule,
          incomingFees: withdrawal.fees ?? [],
          transaction: transaction,
        );

        return retrieve(session, savedRule.id!, transaction: transaction);
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  Future<void> _syncFees(
    Session session, {
    required WithdrawalRule rule,
    required List<WithdrawalFee> incomingFees,
    required Transaction transaction,
  }) async {
    final existingFees = await WithdrawalFee.db.find(
      session,
      where: (e) => e.ruleId.equals(rule.id),
      transaction: transaction,
    );

    if (existingFees.isNotEmpty) {
      await WithdrawalFee.db.delete(
        session,
        existingFees,
        transaction: transaction,
      );
    }

    if (incomingFees.isEmpty) return;

    final feesToInsert = incomingFees.map((f) => f.copyWith(id: null, ruleId: rule.id)).toList();

    await WithdrawalFee.db.insert(
      session,
      feesToInsert,
      transaction: transaction,
    );
  }

  Future<WithdrawalRule> delete(Session session, int id) async {
    final withdrawal = await retrieve(session, id);
    return WithdrawalRule.db.deleteRow(session, withdrawal);
  }
}

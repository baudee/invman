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
          ruleId: savedRule.id!,
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
    required int ruleId,
    required List<WithdrawalFee> incomingFees,
    required Transaction transaction,
  }) async {
    final existingFees = await WithdrawalFee.db.find(
      session,
      where: (e) => e.ruleId.equals(ruleId),
      transaction: transaction,
    );

    final incomingIds = incomingFees
        .where((f) => f.id != null && f.id != 0)
        .map((f) => f.id!)
        .toSet();

    final feesToDelete = existingFees
        .where((f) => !incomingIds.contains(f.id))
        .toList();

    if (feesToDelete.isNotEmpty) {
      await WithdrawalFee.db.delete(
        session,
        feesToDelete,
        transaction: transaction,
      );
    }

    final feesToInsert = <WithdrawalFee>[];
    final feesToUpdate = <WithdrawalFee>[];

    for (final fee in incomingFees) {
      final feeWithRule = fee.copyWith(ruleId: ruleId);
      if (fee.id == null || fee.id == 0) {
        feesToInsert.add(feeWithRule.copyWith(id: null));
      } else {
        feesToUpdate.add(feeWithRule);
      }
    }

    if (feesToInsert.isNotEmpty) {
      await WithdrawalFee.db.insert(
        session,
        feesToInsert,
        transaction: transaction,
      );
    }

    if (feesToUpdate.isNotEmpty) {
      await WithdrawalFee.db.update(
        session,
        feesToUpdate,
        transaction: transaction,
      );
    }
  }

  Future<WithdrawalRule> delete(Session session, int id) async {
    final withdrawal = await retrieve(session, id);
    return WithdrawalRule.db.deleteRow(session, withdrawal);
  }
}

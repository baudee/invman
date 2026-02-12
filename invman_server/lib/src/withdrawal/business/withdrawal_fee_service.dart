import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class WithdrawalFeeService {
  final WithdrawalRuleService ruleService;
  WithdrawalFeeService({required this.ruleService});

  Future<WithdrawalFee> retrieve(Session session, int id) async {
    final withdrawal = await WithdrawalFee.db.findById(
      session,
      id,
      include: IncludeHelpers.withdrawalFeeInclude(),
    );

    if (withdrawal == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final sessionUser = session.authenticated;
    if (withdrawal.rule?.userId != sessionUser!.authUserId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return withdrawal;
  }

  Future<WithdrawalFee> save(Session session, WithdrawalFee fee) async {
    return session.db.transaction(
      (transaction) async {
        await ruleService.retrieve(session, fee.ruleId);

        if (fee.id == 0 || fee.id == null) {
          return WithdrawalFee.db.insertRow(session, fee.copyWith(id: null));
        } else {
          return WithdrawalFee.db.updateRow(session, fee);
        }
      },
    );
  }

  Future<WithdrawalFee> delete(Session session, int id) async {
    final withdrawal = await retrieve(session, id);
    return WithdrawalFee.db.deleteRow(session, withdrawal);
  }
}

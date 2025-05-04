import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class WithdrawalService {
  WithdrawalService();

  Future<WithdrawalList> list(Session session, {int limit = 10, int page = 1}) async {
    final sessionUserId = (await session.authenticated)!.userId;
    final count = await Withdrawal.db.count(session, where: (e) => e.userId.equals(sessionUserId));

    final results = await Withdrawal.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      limit: limit,
      offset: (page * limit) - limit,
    );

    return WithdrawalList(
      count: count,
      limit: limit,
      page: page,
      results: results,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }

  Future<Withdrawal> retrieve(Session session, int id) async {
    final withdrawal = await Withdrawal.db.findById(
      session,
      id,
    );

    if (withdrawal == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final sessionUser = await session.authenticated;
    if (withdrawal.userId != sessionUser!.userId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return withdrawal;
  }

  Future<Withdrawal> save(Session session, Withdrawal withdrawal) async {
    final sessionUser = await session.authenticated;
    if (withdrawal.id != 0 && withdrawal.userId != sessionUser!.userId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    withdrawal.userId = sessionUser!.userId;

    if (withdrawal.id == 0) {
      return Withdrawal.db.insertRow(session, withdrawal);
    } else {
      return Withdrawal.db.updateRow(session, withdrawal);
    }
  }

  Future<Withdrawal> delete(Session session, int id) async {
    final withdrawal = await retrieve(session, id);
    return Withdrawal.db.deleteRow(session, withdrawal);
  }
}

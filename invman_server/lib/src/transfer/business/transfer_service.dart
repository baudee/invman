import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TransferService {
  TransferService();

  Future<TransferList> list(Session session, {int limit = 10, int page = 1}) async {
    final sessionUserId = (await session.authenticated)!.userId;
    final count = await Transfer.db.count(session, where: (e) => e.investment.userId.equals(sessionUserId));

    final results = await Transfer.db.find(
      session,
      where: (e) => e.investment.userId.equals(sessionUserId),
      limit: limit,
      offset: (page * limit) - limit,
    );

    return TransferList(
      count: count,
      limit: limit,
      page: page,
      results: results,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }

  Future<Transfer> retrieve(Session session, int id) async {
    final transfer = await Transfer.db.findById(
      session,
      id,
      include: IncludeHelpers.transferInclude(),
    );

    if (transfer == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final sessionUser = await session.authenticated;
    if (transfer.investment?.userId != sessionUser!.userId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return transfer.copyWith(investment: null);
  }

  Future<Transfer> save(Session session, Transfer transfer) async {
    return session.db.transaction((transaction) async {
      final Transfer savedTransfer;
      if (transfer.id == 0 || transfer.id == null) {
        savedTransfer = await Transfer.db.insertRow(session, transfer, transaction: transaction);
      } else {
        await retrieve(session, transfer.id!);
        savedTransfer = await Transfer.db.updateRow(session, transfer, transaction: transaction);
      }
      return savedTransfer.copyWith();
    });
  }

  Future<Transfer> delete(Session session, int id) async {
    final transfer = await retrieve(session, id);
    return Transfer.db.deleteRow(session, transfer);
  }
}

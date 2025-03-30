import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TransferService {
  TransferService();

  Future<TransferList> list(Session session, {int limit = 10, int page = 1}) async {
    final count = await Transfer.db.count(session);

    final results = await Transfer.db.find(
      session,
      limit: limit,
      offset: (page * limit) - limit,
      include: IncludeHelpers.transferInclude(),
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
    if (transfer.userId != sessionUser!.userId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return transfer;
  }

  Future<Transfer> save(Session session, Transfer transfer) async {
    final sessionUser = await session.authenticated;
    if (transfer.id != 0 && transfer.userId != sessionUser!.userId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    if (transfer.quantity <= 0 || transfer.amount < 0 || transfer.stockId <= 0 || transfer.id == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    transfer.userId = sessionUser!.userId;

    return session.db.transaction((transaction) async {
      final stock = await Stock.db.findById(session, transfer.stockId, transaction: transaction);
      if (stock == null) {
        throw ServerException(errorCode: ErrorCode.badRequest);
      }

      final Transfer savedTransfer;
      if (transfer.id == 0) {
        savedTransfer = await Transfer.db.insertRow(session, transfer, transaction: transaction);
      } else {
        savedTransfer = await Transfer.db.updateRow(session, transfer, transaction: transaction);
      }
      return savedTransfer.copyWith(
        stock: stock,
      );
    });
  }
}

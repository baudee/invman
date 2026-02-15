import 'package:injectable/injectable.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/investment/investment.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class TransferService {
  TransferService({required this.investmentService});

  final InvestmentService investmentService;

  Future<Transfer> retrieve(Session session, int id) async {
    final transfer = await Transfer.db.findById(
      session,
      id,
    );

    if (transfer == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    await investmentService.retrieve(session, transfer.investmentId);

    return transfer.copyWith(investment: null);
  }

  Future<Transfer> save(Session session, Transfer transfer) async {
    return session.db.transaction(
      (transaction) async {
        final Transfer savedTransfer;
        if (transfer.id == 0 || transfer.id == null) {
          savedTransfer = await Transfer.db.insertRow(
            session,
            transfer.copyWith(id: null),
            transaction: transaction,
          );
        } else {
          await retrieve(session, transfer.id!);
          savedTransfer = await Transfer.db.updateRow(
            session,
            transfer,
            transaction: transaction,
          );
        }

        await investmentService.updateTotalTransfers(session, savedTransfer.investmentId, transaction: transaction);

        return savedTransfer;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  Future<Transfer> delete(Session session, int id) async {
    return session.db.transaction(
      (transaction) async {
        final transfer = await retrieve(session, id);
        final deletedTransfer = await Transfer.db.deleteRow(session, transfer, transaction: transaction);
        await investmentService.updateTotalTransfers(session, transfer.investmentId, transaction: transaction);
        return deletedTransfer;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  Future<List<Transfer>> list(Session session, int investmentId, {required int limit, required int page}) async {
    await investmentService.retrieve(session, investmentId);

    return Transfer.db.find(
      session,
      where: (e) => e.investmentId.equals(investmentId),
      limit: limit,
      offset: (page * limit) - limit,
    );
  }
}

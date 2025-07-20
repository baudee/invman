import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/investment/investment.dart';
import 'package:serverpod/serverpod.dart';

class TransferService {
  TransferService({required this.investmentService});

  final InvestmentService investmentService;

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
    return session.db.transaction(
      (transaction) async {
        final investment = await Investment.db.findById(session, transfer.investmentId);
        await investmentService.retrieveChecks(session, investment: investment);

        final Transfer savedTransfer;
        if (transfer.id == 0 || transfer.id == null) {
          savedTransfer = await Transfer.db.insertRow(session, transfer, transaction: transaction);
        } else {
          await retrieve(session, transfer.id!);
          savedTransfer = await Transfer.db.updateRow(session, transfer, transaction: transaction);
        }

        await Investment.db.updateRow(session, investment!.copyWith(updatedAt: DateTime.now()));

        return savedTransfer;
      },
      settings: TransactionSettings(isolationLevel: IsolationLevel.serializable),
    );
  }

  Future<Transfer> delete(Session session, int id) async {
    final transfer = await retrieve(session, id);
    return Transfer.db.deleteRow(session, transfer);
  }
}

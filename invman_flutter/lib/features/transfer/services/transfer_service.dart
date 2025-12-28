import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class TransferService {
  final Client client;

  const TransferService(this.client);

  Future<Either<String, Transfer>> retrieve(int id) async {
    return safeCall(() async {
      Transfer transfer = await client.transfer.retrieve(id);
      return right(transfer.copyWith(createdAt: transfer.createdAt.toLocal()));
    });
  }

  Future<Either<String, Transfer>> save(Transfer transfer) async {
    return safeCall(() async {
      Transfer savedTransfer = await client.transfer.save(transfer);
      return right(savedTransfer.copyWith(createdAt: savedTransfer.createdAt.toLocal()));
    });
  }

  Future<Either<String, Transfer>> delete(int id) async {
    return safeCall(() async {
      return right(await client.transfer.delete(id));
    });
  }

  Future<Either<String, TransferList>> list(int investmentId, {required int page, required int limit}) async {
    return safeCall(() async {
      final TransferList transferList = await client.transfer.list(investmentId, page: page, limit: limit);
      final localTransfers = transferList.results
          .map((transfer) => transfer.copyWith(createdAt: transfer.createdAt.toLocal()))
          .toList();
      final localTransferList = transferList.copyWith(results: localTransfers);
      return right(localTransferList);
    });
  }
}

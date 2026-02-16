import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class TransferRepository {
  final Client client;

  const TransferRepository(this.client);

  Future<Either<String, Transfer>> retrieve(int id) async {
    return safeCall(() async {
      Transfer transfer = await client.transfer.retrieve(id);
      return right(transfer.copyWith(createdAt: transfer.createdAt.toLocal()));
    });
  }

  Future<Either<String, Transfer>> save(Transfer transfer) async {
    return safeCall(() async {
      final transferUtc = transfer.copyWith(
        createdAt: transfer.createdAt.toUtc(),
      );
      Transfer savedTransfer = await client.transfer.save(transferUtc);
      return right(
        savedTransfer.copyWith(createdAt: savedTransfer.createdAt.toLocal()),
      );
    });
  }

  Future<Either<String, Transfer>> delete(int id) async {
    return safeCall(() async {
      return right(await client.transfer.delete(id));
    });
  }

  Future<Either<String, List<Transfer>>> list(
    int investmentId, {
    required int page,
    required int limit,
  }) async {
    return safeCall(() async {
      final transfers = await client.transfer.list(
        investmentId,
        page: page,
        limit: limit,
      );
      final localTransfers = transfers
          .map(
            (transfer) =>
                transfer.copyWith(createdAt: transfer.createdAt.toLocal()),
          )
          .toList();
      return right(localTransfers);
    });
  }
}

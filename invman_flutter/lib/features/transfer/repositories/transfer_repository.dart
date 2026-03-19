import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class TransferRepository {
  final Client client;

  TransferRepository(this.client);

  final _invalidation = signal(false);
  ReadonlySignal<bool> get invalidation => _invalidation;

  void _notifyChange() => _invalidation.value = !_invalidation.value;

  Future<Either<String, Transfer>> retrieve(int id) async {
    return safeCall(() async {
      Transfer transfer = await client.transfer.retrieve(id);
      return right(transfer);
    });
  }

  Future<Either<String, Transfer>> save(Transfer transfer) async {
    final result = await safeCall(() async {
      Transfer savedTransfer = await client.transfer.save(transfer);
      return right(savedTransfer);
    });
    if (result.isRight()) _notifyChange();
    return result;
  }

  Future<Either<String, Transfer>> delete(int id) async {
    final result = await safeCall(() async {
      return right(await client.transfer.delete(id));
    });
    if (result.isRight()) _notifyChange();
    return result;
  }

  Future<Either<String, List<Transfer>>> list(int investmentId, {required int page, required int limit}) async {
    return safeCall(() async {
      final transfers = await client.transfer.list(investmentId, page: page, limit: limit);
      return right(transfers);
    });
  }
}

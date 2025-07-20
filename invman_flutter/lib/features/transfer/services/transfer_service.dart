import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class TransferService {
  final Client client;

  const TransferService(this.client);

  Future<Either<String, Transfer>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.transfer.retrieve(id));
    });
  }

  Future<Either<String, Transfer>> save(Transfer transfer) async {
    return safeCall(() async {
      return right(await client.transfer.save(transfer));
    });
  }

  Future<Either<String, Transfer>> delete(int id) async {
    return safeCall(() async {
      return right(await client.transfer.delete(id));
    });
  }
}

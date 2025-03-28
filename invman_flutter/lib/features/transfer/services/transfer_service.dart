import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class TransferService {
  final Client client;

  const TransferService(this.client);

  Future<Either<String, TransferList>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.transfer.list(limit: limit, page: page));
    });
  }
}

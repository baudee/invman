import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class WithdrawalService {
  final Client client;

  const WithdrawalService(this.client);

  Future<Either<String, WithdrawalList>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.withdrawal.list(limit: limit, page: page));
    });
  }

  Future<Either<String, Withdrawal>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.withdrawal.retrieve(id));
    });
  }

  Future<Either<String, Withdrawal>> save(Withdrawal withdrawal) async {
    return safeCall(() async {
      return right(await client.withdrawal.save(withdrawal));
    });
  }

  Future<Either<String, Withdrawal>> delete(int id) async {
    return safeCall(() async {
      return right(await client.withdrawal.delete(id));
    });
  }
}

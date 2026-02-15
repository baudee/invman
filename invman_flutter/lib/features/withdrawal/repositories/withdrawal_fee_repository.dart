import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class WithdrawalFeeRepository {
  final Client client;

  const WithdrawalFeeRepository(this.client);

  Future<Either<String, WithdrawalFee>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.withdrawalFee.retrieve(id));
    });
  }

  Future<Either<String, WithdrawalFee>> save(WithdrawalFee withdrawal) async {
    return safeCall(() async {
      return right(await client.withdrawalFee.save(withdrawal));
    });
  }

  Future<Either<String, WithdrawalFee>> delete(int id) async {
    return safeCall(() async {
      return right(await client.withdrawalFee.delete(id));
    });
  }
}

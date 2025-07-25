import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class WithdrawalRuleService {
  final Client client;

  const WithdrawalRuleService(this.client);

  Future<Either<String, WithdrawalRuleList>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.withdrawalRule.list(limit: limit, page: page));
    });
  }

  Future<Either<String, WithdrawalRule>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.withdrawalRule.retrieve(id));
    });
  }

  Future<Either<String, WithdrawalRule>> save(WithdrawalRule withdrawal) async {
    return safeCall(() async {
      return right(await client.withdrawalRule.save(withdrawal));
    });
  }

  Future<Either<String, WithdrawalRule>> delete(int id) async {
    return safeCall(() async {
      return right(await client.withdrawalRule.delete(id));
    });
  }
}

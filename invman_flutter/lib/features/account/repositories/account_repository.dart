import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class AccountRepository {
  final Client client;

  const AccountRepository(this.client);

  Future<Either<String, Account>> retrieve() async {
    return safeCall(() async {
      return right(await client.account.retrieve());
    });
  }

  Future<Either<String, Account>> save(Account account) async {
    return safeCall(() async {
      return right(await client.account.save(account));
    });
  }
}

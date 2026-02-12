import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class AccountService {
  final Client client;

  const AccountService(this.client);

  Future<Either<String, Account>> retrieve() async {
    return safeCall(() async {
      return right(await client.account.retrieve());
    });
  }

  Future<Account> save(Account account) async {
    return safeCallTest(() => client.account.save(account));
  }
}

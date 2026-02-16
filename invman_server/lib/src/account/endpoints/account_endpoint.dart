import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/account/account.dart';
import 'package:serverpod/serverpod.dart';

class AccountEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<Account> retrieve(Session session) async {
    return withMiddleware(
      session,
      () => getIt<AccountService>().retrieve(session),
    );
  }

  Future<Account> save(Session session, Account account) async {
    return withMiddleware(
      session,
      () => getIt<AccountService>().save(session, account),
    );
  }
}

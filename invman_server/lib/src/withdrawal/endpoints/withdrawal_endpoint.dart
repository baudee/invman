import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';

class WithdrawalEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<WithdrawalList> list(Session session, {int limit = 10, int page = 1}) async {
    return withMiddleware(session, () => getIt<WithdrawalService>().list(session, limit: limit, page: page));
  }

  Future<Withdrawal> retrieve(Session session, int id) async {
    return withMiddleware(session, () => getIt<WithdrawalService>().retrieve(session, id));
  }

  Future<Withdrawal> save(Session session, Withdrawal transfer) async {
    return withMiddleware(session, () => getIt<WithdrawalService>().save(session, transfer));
  }

  Future<Withdrawal> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<WithdrawalService>().delete(session, id));
  }
}

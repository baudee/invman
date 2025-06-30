import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';

class WithdrawalRuleEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<WithdrawalRuleList> list(Session session, {int limit = 10, int page = 1}) async {
    return withMiddleware(session, () => getIt<WithdrawalRuleService>().list(session, limit: limit, page: page));
  }

  Future<WithdrawalRule> retrieve(Session session, int id) async {
    return withMiddleware(session, () => getIt<WithdrawalRuleService>().retrieve(session, id));
  }

  Future<WithdrawalRule> save(Session session, WithdrawalRule transfer) async {
    return withMiddleware(session, () => getIt<WithdrawalRuleService>().save(session, transfer));
  }

  Future<WithdrawalRule> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<WithdrawalRuleService>().delete(session, id));
  }
}

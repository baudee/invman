import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';

class WithdrawalFeeEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<WithdrawalFee> retrieve(Session session, int id) async {
    return withMiddleware(session, () => getIt<WithdrawalFeeService>().retrieve(session, id));
  }

  Future<WithdrawalFee> save(Session session, WithdrawalFee fee) async {
    return withMiddleware(session, () => getIt<WithdrawalFeeService>().save(session, fee));
  }

  Future<WithdrawalFee> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<WithdrawalFeeService>().delete(session, id));
  }
}

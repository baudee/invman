import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/features/investment/investment.dart';
import 'package:serverpod/serverpod.dart';

class InvestmentEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Investment>> list(Session session, {int limit = 10, int page = 1}) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().list(session, limit: limit, page: page),
    );
  }

  Future<Investment> save(Session session, Investment investment) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().save(session, investment),
    );
  }

  Future<Investment> delete(Session session, int id) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().delete(session, id),
    );
  }

  Future<Investment> retrieve(Session session, int id) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().retrieve(session, id),
    );
  }

  Future<Investment> total(Session session) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().total(session),
    );
  }

  Future<List<InvestmentReturn>> returns(Session session, int id, {required InvestmentReturnInterval interval}) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().returns(session, id, interval: interval),
    );
  }

  Future<List<InvestmentReturn>> totalReturns(Session session, {required InvestmentReturnInterval interval}) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().totalReturns(session, interval: interval),
    );
  }
}

import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/investment/investment.dart';
import 'package:serverpod/serverpod.dart';

class InvestmentEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<InvestmentList> list(
    Session session, {
    required String currency,
    int limit = 10,
    int page = 1,
  }) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().list(
        session,
        currency: currency.toUpperCase(),
        limit: limit,
        page: page,
      ),
    );
  }

  Future<Investment> total(
    Session session, {
    required String currency,
  }) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().total(
        session,
        currency: currency.toUpperCase(),
      ),
    );
  }

  Future<Investment> save(Session session, Investment investment, {required String currency}) async {
    return withMiddleware(session, () => getIt<InvestmentService>().save(session, investment, currency: currency));
  }

  Future<Investment> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<InvestmentService>().delete(session, id));
  }

  Future<Investment> retrieve(Session session, int id, {required String currency}) async {
    return withMiddleware(session, () => getIt<InvestmentService>().retrieve(session, id, currency: currency));
  }
}

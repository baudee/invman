import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/investment/investment.dart';
import 'package:serverpod/serverpod.dart';

class InvestmentEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Investment>> list(Session session) async {
    return withMiddleware(session, () => getIt<InvestmentService>().list(session));
  }

  Future<Investment> save(Session session, Investment investment) async {
    return withMiddleware(session, () => getIt<InvestmentService>().save(session, investment));
  }

  Future<Investment> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<InvestmentService>().delete(session, id));
  }

  Future<Investment> retrieve(Session session, int id) async {
    return withMiddleware(session, () => getIt<InvestmentService>().retrieve(session, id));
  }
}

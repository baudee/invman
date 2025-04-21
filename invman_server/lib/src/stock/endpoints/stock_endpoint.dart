import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';

class StockEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<StockList> list(Session session, {int limit = 10, int page = 1}) async {
    return withMiddleware(session, () => getIt<StockService>().list(session, limit: limit, page: page));
  }

  Future<Stock> retrieve(Session session, int id) async {
    return withMiddleware(session, () => getIt<StockService>().retrieve(session, id));
  }

  Future<List<Stock>> search(Session session, {required String query, int limit = 10}) async {
    return withMiddleware(session, () => getIt<StockService>().search(session, query: query, limit: limit));
  }

  Future<Stock> save(Session session, String symbol) async {
    return withMiddleware(session, () => getIt<StockService>().save(session, symbol));
  }

  Future<Stock> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<StockService>().delete(session, id));
  }
}

import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';

class StockEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<Stock> retrieve(Session session, String symbol) async {
    return withMiddleware(session, () => getIt<StockService>().retrieve(session, symbol));
  }

  Future<List<Stock>> search(Session session, {required String query, int limit = 10}) async {
    return withMiddleware(session, () => getIt<StockService>().search(session, query: query, limit: limit));
  }
}

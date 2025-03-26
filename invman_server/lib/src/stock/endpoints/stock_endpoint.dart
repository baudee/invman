import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';

class StockEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<StockList> list(Session session, {int limit = 10, int page = 1}) async {
    return getIt<StockService>().list(session, limit: limit, page: page);
  }

  Future<StockList> search(Session session, {required String query, int limit = 10}) async {
    return getIt<StockService>().search(session, query: query, limit: limit);
  }

  Future<Stock> save(Session session, Stock stock) async {
    return getIt<StockService>().save(session, stock);
  }
}

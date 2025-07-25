import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/data/data.dart';
import 'package:serverpod/serverpod.dart';

class StockService {
  final StockClient stockClient;

  StockService({required this.stockClient});

  Future<Stock> retrieve(Session session, String symbol) async {
    return stockClient.get(symbol: symbol);
  }

  Future<List<Stock>> search(Session session, {required String query, int limit = 10}) async {
    return stockClient.search(query: query, limit: limit);
  }
}

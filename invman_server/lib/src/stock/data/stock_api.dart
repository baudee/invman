import 'package:invman_server/src/generated/protocol.dart';

abstract interface class StockApi {
  Future<List<Stock>> search({required String query, int limit = 10});
  Future<Stock> get({required String symbol});
  Future<int> currencyChange({required String from, required String to});
}

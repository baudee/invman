import 'package:invman_server/src/generated/protocol.dart';

abstract interface class StockClient {
  Future<List<Stock>> search({required String query, int limit = 10});
  Future<Stock> get({required String symbol});
  Future<double> currencyChange({required String from, required String to});
}

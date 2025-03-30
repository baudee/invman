import 'package:invman_server/src/generated/protocol.dart';

abstract interface class StockApi {
  Future<List<Stock>> search({required String query, int limit = 10});
}

import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class StockService {
  final Client client;

  const StockService(this.client);

  Future<Either<String, List<Stock>>> search({required String query, int limit = 30}) async {
    return safeCall(() async {
      return right(await client.stock.search(query: query, limit: limit));
    });
  }

  Future<Either<String, Stock>> retrieve(String symbol) async {
    return safeCall(() async {
      return right(await client.stock.retrieve(symbol));
    });
  }
}

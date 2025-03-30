import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class StockService {
  final Client client;

  const StockService(this.client);

  Future<Either<String, StockList>> search({required String query, int limit = 30}) async {
    return safeCall(() async {
      return right(await client.stock.search(query: query, limit: limit));
    });
  }

  Future<Either<String, StockList>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.stock.list(limit: limit, page: page));
    });
  }

  Future<Either<String, Stock>> save(Stock stock) async {
    return safeCall(() async {
      return right(await client.stock.save(stock));
    });
  }
}

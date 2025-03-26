import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';

class StockService {
  final Client client;

  const StockService(this.client);

  Future<Either<String, StockList>> search({required String query, int limit = 30}) async {
    try {
      final result = await client.stock.search(query: query, limit: limit);
      return right(result);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }

  Future<Either<String, StockList>> list({required int page, required int limit}) async {
    try {
      final result = await client.stock.list(limit: limit, page: page);
      return right(result);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }

  Future<Either<String, Stock>> save(Stock stock) async {
    try {
      final result = await client.stock.save(stock);
      return right(result);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }
}

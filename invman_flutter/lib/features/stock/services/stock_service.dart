import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';

class StockService {
  final Client client;

  const StockService(this.client);

  Future<Either<String, StockList>> search({required String query}) async {
    try {
      final result = await client.stock.search(query: query);
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
}

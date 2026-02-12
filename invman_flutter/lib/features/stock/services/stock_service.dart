import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class StockService {
  final Client client;

  const StockService(this.client);

  Future<Either<String, StockList>> search({required String query, int limit = 10, int page = 1}) async {
    return safeCall(() async {
      return right(await client.stock.search(query: query, limit: limit, page: page));
    });
  }

  Future<Stock> retrieve(UuidValue uuid) async {
    return client.stock.retrieve(uuid);
  }
}

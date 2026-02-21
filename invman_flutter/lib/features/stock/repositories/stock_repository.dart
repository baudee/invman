import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class StockRepository {
  final Client client;

  const StockRepository(this.client);

  Future<Either<String, List<Stock>>> search({required String query, int limit = 10, int page = 1}) async {
    return safeCall(() async {
      return right(await client.stock.search(query: query, limit: limit, page: page));
    });
  }

  Future<Either<String, Stock>> retrieve(UuidValue uuid) async {
    return safeCall(() async {
      return right(await client.stock.retrieve(uuid));
    });
  }

  Future<Either<String, void>> like(UuidValue stockId) async {
    return safeCall(() async {
      await client.stock.like(stockId);
      return right(null);
    });
  }

  Future<Either<String, void>> unlike(UuidValue stockId) async {
    return safeCall(() async {
      await client.stock.unlike(stockId);
      return right(null);
    });
  }

  Future<Either<String, List<Stock>>> listPopular({int limit = 10, int page = 1}) async {
    return safeCall(() async {
      return right(await client.stock.listPopular(limit: limit, page: page));
    });
  }

  Future<Either<String, List<Stock>>> listLiked({int limit = 10, int page = 1}) async {
    return safeCall(() async {
      return right(await client.stock.listLiked(limit: limit, page: page));
    });
  }
}

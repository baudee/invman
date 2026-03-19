import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class StockRepository {
  final Client client;

  final _invalidationLikedStocks = signal(false);
  ReadonlySignal<bool> get invalidationLikedStocks => _invalidationLikedStocks;

  void _notifyLikeChange() => _invalidationLikedStocks.value = !_invalidationLikedStocks.value;

  StockRepository(this.client);

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
      _notifyLikeChange();
      return right(null);
    });
  }

  Future<Either<String, void>> unlike(UuidValue stockId) async {
    return safeCall(() async {
      await client.stock.unlike(stockId);
      _notifyLikeChange();
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

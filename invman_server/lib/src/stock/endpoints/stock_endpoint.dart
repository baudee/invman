import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';

class StockEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<void> like(Session session, UuidValue stockId) async {
    return withMiddleware(
      session,
      () => getIt<StockService>().like(session, stockId),
    );
  }

  Future<void> unlike(Session session, UuidValue stockId) async {
    return withMiddleware(
      session,
      () => getIt<StockService>().unlike(session, stockId),
    );
  }

  Future<Stock> retrieve(Session session, UuidValue uuid) async {
    return withMiddleware(
      session,
      () => getIt<StockService>().retrieve(session, uuid),
    );
  }

  Future<List<Stock>> list(
    Session session, {
    StockFilter? filter,
    int limit = 10,
    int page = 1,
  }) async {
    return withMiddleware(
      session,
      () => getIt<StockService>().list(
        session,
        filter: filter ?? StockFilter(),
        limit: limit,
        page: page,
      ),
    );
  }
}

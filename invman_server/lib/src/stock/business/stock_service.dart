import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/data/data.dart';
import 'package:serverpod/serverpod.dart';

class StockService {
  final StockApi stockApi;

  StockService({required this.stockApi});

  Future<StockList> list(Session session, {int limit = 10, int page = 1}) async {
    final count = await Stock.db.count(session);

    final results = await Stock.db.find(
      session,
      limit: limit,
      offset: (page * limit) - limit,
    );

    return StockList(
      count: count,
      limit: limit,
      page: page,
      results: results,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }

  Future<StockList> search(Session session, {required String query}) async {
    final results = await stockApi.search(query: query);
    final count = results.length;
    return StockList(
      count: count,
      limit: count,
      page: 1,
      results: results,
      numPages: 1,
      canLoadMore: false,
    );
  }
}

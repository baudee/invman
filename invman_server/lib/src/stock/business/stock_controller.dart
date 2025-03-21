import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class StockController {
  static Future<StockList> list(Session session, {int limit = 10, int page = 1}) async {
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
}

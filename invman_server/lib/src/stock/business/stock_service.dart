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

  Future<Stock> retrieve(Session session, int id) async {
    final stock = await Stock.db.findById(
      session,
      id,
    );

    if (stock == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    return stock;
  }

  Future<List<Stock>> search(Session session, {required String query, int limit = 10}) async {
    return stockApi.search(query: query, limit: limit);
  }

  Future<Stock> save(Session session, String symbol) async {
    return session.db.transaction((transaction) async {
      final existingStock = await Stock.db.findFirstRow(
        session,
        where: (e) => e.symbol.equals(symbol),
        transaction: transaction,
      );
      if (existingStock != null) {
        throw ServerException(errorCode: ErrorCode.conflict);
      }
      final stock = await stockApi.get(symbol: symbol);
      return Stock.db.insertRow(session, stock, transaction: transaction);
    });
  }

  Future<Stock> delete(Session session, int id) async {
    return session.db.transaction((transaction) async {
      final stock = await Stock.db.findById(
        session,
        id,
        transaction: transaction,
      );
      if (stock == null) {
        throw ServerException(errorCode: ErrorCode.notFound);
      }
      return Stock.db.deleteRow(session, stock, transaction: transaction);
    });
  }
}

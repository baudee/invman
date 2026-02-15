import 'package:injectable/injectable.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class StockService {
  StockService();

  Future<Stock> retrieve(Session session, UuidValue uuid, {Transaction? transaction}) async {
    final stock = await Stock.db.findById(session, uuid, transaction: transaction);
    if (stock == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }
    return stock;
  }

  Future<List<Stock>> search(Session session, {required String query, required int limit, required int page}) async {
    return Stock.db.find(
      session,
      where: (e) => e.shortName.ilike("%${query.trim()}%") | e.longName.ilike("%${query.trim()}%"),
      limit: limit,
      offset: (page * limit) - limit,
    );
  }
}

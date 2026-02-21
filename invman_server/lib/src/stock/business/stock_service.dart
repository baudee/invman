import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/include_helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class StockService {
  StockService();

  Future<void> like(Session session, UuidValue stockId) async {
    final userId = (session.authenticated)!.authUserId;

    final existingLike = await StockLike.db.findFirstRow(
      session,
      where: (e) => e.userId.equals(userId) & e.stockId.equals(stockId),
    );

    if (existingLike != null) {
      return;
    }

    await StockLike.db.insertRow(
      session,
      StockLike(userId: userId, stockId: stockId),
    );
  }

  Future<void> unlike(Session session, UuidValue stockId) async {
    final userId = (session.authenticated)!.authUserId;

    final existingLike = await StockLike.db.findFirstRow(
      session,
      where: (e) => e.userId.equals(userId) & e.stockId.equals(stockId),
    );

    if (existingLike == null) {
      return;
    }

    await StockLike.db.deleteRow(session, existingLike);
  }

  Future<Stock> retrieve(
    Session session,
    UuidValue uuid, {
    Transaction? transaction,
  }) async {
    final userId = session.authenticated!.authUserId;
    final stock = await Stock.db.findById(
      session,
      uuid,
      include: IncludeHelpers.stockInclude(userId: userId),
      transaction: transaction,
    );
    if (stock == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }
    return stock;
  }

  Future<List<Stock>> search(
    Session session, {
    required String query,
    required int limit,
    required int page,
  }) async {
    return Stock.db.find(
      session,
      where: (e) => e.name.ilike("%${query.trim()}%") | e.symbol.ilike("%${query.trim()}%"),
      limit: limit,
      offset: (page * limit) - limit,
    );
  }

  Future<List<Stock>> listPopular(
    Session session, {
    required int limit,
    required int page,
  }) async {
    return Stock.db.find(
      session,
      orderBy: (t) => t.investments.count(),
      orderDescending: true,
      limit: limit,
      offset: (page * limit) - limit,
    );
  }

  Future<List<Stock>> listLiked(
    Session session, {
    required int limit,
    required int page,
  }) async {
    final userId = session.authenticated!.authUserId;

    return Stock.db.find(
      session,
      where: (e) => e.likes.any((like) => like.userId.equals(userId)),
      limit: limit,
      offset: (page * limit) - limit,
    );
  }
}

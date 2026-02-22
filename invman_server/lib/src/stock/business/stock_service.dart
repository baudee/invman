import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/core/helpers/include_helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class StockService {
  final StockCurrentValuesSource currentValuesSource;
  StockService(this.currentValuesSource);

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
    Stock? stock = await Stock.db.findById(
      session,
      uuid,
      include: IncludeHelpers.stockInclude(userId: userId),
      transaction: transaction,
    );
    if (stock == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    // Last update is more than X day ago, update the price
    if (stock.updatedAt.isBefore(DateTime.now().subtract(const Duration(days: cacheDurationDays)))) {
      final (double currentValue, DateTime timestamp) = await currentValuesSource.getCurrentValue(
        stock.symbol,
        stock.name,
      );

      stock = await Stock.db.updateRow(
        session,
        stock.copyWith(
          price: currentValue,
          updatedAt: timestamp,
        ),
        transaction: transaction,
      );
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

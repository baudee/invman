import 'package:injectable/injectable.dart' hide Order;
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class StockService {
  final StockCurrentValuesSource currentValuesSource;
  final Env env;
  StockService(this.currentValuesSource, this.env);

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
    if (stock.updatedAt.isBefore(DateTime.now().subtract(Duration(days: env.cacheDurationDays)))) {
      final currentValue = await currentValuesSource.getCurrentValue(
        StockCurrentValueInput(
          symbol: stock.symbol,
          name: stock.name,
          currencyCode: stock.currency!.code,
        ),
      );

      stock = await Stock.db.updateRow(
        session,
        stock.copyWith(
          price: currentValue.value,
          timestamp: currentValue.timestamp,
          updatedAt: DateTime.now(),
        ),
        transaction: transaction,
      );
    }

    return stock;
  }

  Future<List<Stock>> list(
    Session session, {
    required StockFilter filter,
    required int limit,
    required int page,
  }) async {
    return Stock.db.find(
      session,
      where: _getWhereFromFilter(filter, session.authenticated!.authUserId),
      orderByList: _getOrderListFromFilter(filter),
      limit: limit,
      offset: (page * limit) - limit,
      include: Stock.include(
        currency: Currency.include(),
      ),
    );
  }

  Future<List<Stock>> addCurrentValues(
    Session session,
    List<Stock> stocks, {
    Transaction? transaction,
  }) async {
    final inputs = stocks
        .map(
          (stock) => StockCurrentValueInput(
            symbol: stock.symbol,
            name: stock.name,
            currencyCode: stock.currency!.code,
          ),
        )
        .toList();

    final currentValues = await currentValuesSource.getCurrentValues(inputs);

    final updatedStocks = <Stock>[];
    for (var i = 0; i < stocks.length; i++) {
      final stock = stocks[i];
      final currentValue = currentValues[i];

      updatedStocks.add(
        stock.copyWith(
          price: currentValue.value,
          timestamp: currentValue.timestamp,
          updatedAt: DateTime.now(),
        ),
      );
    }

    await Stock.db.update(
      session,
      updatedStocks,
      transaction: transaction,
    );

    return updatedStocks;
  }

  Expression Function(StockTable)? _getWhereFromFilter(StockFilter filter, UuidValue userId) {
    final List<Expression> expressions = [];

    return (StockTable t) {
      if (filter.favorite) {
        expressions.add(t.likes.any((like) => like.userId.equals(userId)));
      }

      if (filter.query != null && filter.query!.trim().isNotEmpty) {
        final q = "%${filter.query!.trim()}%";
        expressions.add(t.symbol.ilike(q) | t.name.ilike(q));
      }

      if (filter.type != null) {
        expressions.add(t.quoteType.equals(filter.type!));
      }

      return expressions.and ?? Constant.bool(true);
    };
  }

  List<Order> Function(StockTable)? _getOrderListFromFilter(StockFilter filter) {
    return (StockTable t) {
      return [
        Order(column: t.investments.count(), orderDescending: true),
        Order(column: t.likes.count(), orderDescending: true),
      ];
    };
  }
}

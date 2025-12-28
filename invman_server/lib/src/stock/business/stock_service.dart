import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/data/data.dart';
import 'package:serverpod/serverpod.dart';

class StockService {
  final StockClient stockClient;
  final Duration cacheDuration = Duration(minutes: 5);

  StockService({required this.stockClient});

  Future<Stock> retrieve(Session session, String symbol, {Transaction? transaction}) async {
    final cacheKey = 'StockRetrieve_$symbol';
    final cachedStock = await session.caches.local.get<Stock>(cacheKey);

    if (cachedStock == null) {
      Stock? stock = await Stock.db.findFirstRow(
        session,
        where: (s) => s.symbol.equals(symbol),
        transaction: transaction,
      );

      if (stock == null || stock.updatedAt.isBefore(DateTime.now().subtract(cacheDuration))) {
        final stockData = await stockClient.get(symbol: symbol);
        Stock savedStock;
        if (stock == null) {
          // Create new stock entry
          savedStock = await Stock.db.insertRow(session, stockData, transaction: transaction);
        } else {
          // Update existing stock entry
          stock = stock.copyWith(
            quoteType: stockData.quoteType,
            name: stockData.name,
            currency: stockData.currency,
            value: stockData.value,
            updatedAt: DateTime.now(),
          );
          savedStock = await Stock.db.updateRow(session, stock, transaction: transaction);
        }
        await session.caches.local.put(cacheKey, savedStock, lifetime: cacheDuration);
        return savedStock;
      } else {
        return stock;
      }
    } else {
      return cachedStock;
    }
  }

  Future<List<Stock>> search(Session session, {required String query, int limit = 10}) async {
    final cacheKey = 'StockSearch_${query}_$limit';
    final cachedSearch = await session.caches.local.get<CachedStockSearch>(cacheKey);

    if (cachedSearch != null) {
      return cachedSearch.stocks;
    } else {
      final stocks = await stockClient.search(query: query, limit: limit);
      await session.caches.local.put(
        cacheKey,
        CachedStockSearch(stocks: stocks),
        lifetime: cacheDuration,
      );
      return stocks;
    }
  }

  Future<double> currencyChange(Session session, {required String from, required String to}) async {
    final cachedKey = 'CurrencyChange_${from}_$to';
    final cachedCurrency = await session.caches.local.get<CachedCurrencyChange>(cachedKey);

    if (cachedCurrency != null) {
      return cachedCurrency.currencyChange;
    } else {
      final currencyChange = await stockClient.currencyChange(from: from, to: to);
      await session.caches.local.put(
        cachedKey,
        CachedCurrencyChange(currencyChange: currencyChange),
        lifetime: cacheDuration,
      );
      return currencyChange;
    }
  }
}

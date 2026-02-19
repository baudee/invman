import 'package:injectable/injectable.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'currency_data.dart';
import 'stock_data.dart';

@injectable
class SeedService {
  Future<void> seedIfNeeded(Session session) async {
    await _seedCurrencies(session);
    await _seedStocks(session);
  }

  Future<void> _seedCurrencies(Session session) async {
    final count = await Currency.db.count(session);
    if (count > 0) return;

    await Currency.db.insert(session, seedCurrencies);
    session.log('[Seed] Inserted ${seedCurrencies.length} currencies');
  }

  Future<void> _seedStocks(Session session) async {
    final count = await Stock.db.count(session);
    if (count > 0) return;

    final currencies = await Currency.db.find(session);
    final stocks = getSeedStocks(currencies);

    await Stock.db.insert(session, stocks);
    session.log('[Seed] Inserted ${stocks.length} stocks');
  }
}

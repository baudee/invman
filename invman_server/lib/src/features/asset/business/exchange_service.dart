import 'package:injectable/injectable.dart' hide Order;
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class ExchangeService {
  ExchangeService();

  Future<List<String>> listAll(Session session) async {
    List<String>? exchanges = await session.caches.local.get(CacheKeys.exchangesList);
    if (exchanges == null) {
      final assets = await Asset.db.find(session, where: (a) => a.exchange.notEquals(null));
      // keep only distinct and sort
      exchanges = assets.map((a) => a.exchange!).toSet().toList()..sort();
      await session.caches.local.put(CacheKeys.exchangesList, exchanges, lifetime: Duration(days: 1));
    }
    return exchanges;
  }
}

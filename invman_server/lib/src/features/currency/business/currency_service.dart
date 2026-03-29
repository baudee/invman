import 'package:injectable/injectable.dart';
import 'package:invman_server/src/features/currency/currency.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class CurrencyService {
  final ForexValuesSource forexValuesSource;
  final Env env;
  CurrencyService(this.forexValuesSource, this.env);

  Future<List<Currency>> list(Session session) async {
    return Currency.db.find(session, orderBy: (c) => c.code);
  }

  Future<Currency> retrieve(
    Session session,
    int id, {
    Transaction? transaction,
  }) async {
    Currency? currency = await Currency.db.findById(
      session,
      id,
      transaction: transaction,
    );

    if (currency == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    return currency;
  }

  Future<Forex> change(
    Session session, {
    required String fromCode,
    required String toCode,
  }) async {
    final fromCurrencyDollarValue = await _getCachedDollarValue(session, code: fromCode);
    final toCurrencyDollarValue = await _getCachedDollarValue(session, code: toCode);

    return _getForexFromAssetValues(fromCurrencyDollarValue, toCurrencyDollarValue, fromCode, toCode);
  }

  Future<Forex> changeEod(
    Session session, {
    required String fromCode,
    required String toCode,
    required DateTime date,
  }) async {
    final fromCurrencyDollarValue = await _getCachedEodDollarValue(session, code: fromCode, date: date);
    final toCurrencyDollarValue = await _getCachedEodDollarValue(session, code: toCode, date: date);

    return _getForexFromAssetValues(fromCurrencyDollarValue, toCurrencyDollarValue, fromCode, toCode);
  }

  Forex _getForexFromAssetValues(AssetValue fromAssetValue, AssetValue toAssetValue, String fromCode, String toCode) {
    if (fromAssetValue.value == 0) {
      throw ServerException(errorCode: ErrorCode.unknown);
    }

    final DateTime forexTimestamp;
    if (toCode == "USD") {
      forexTimestamp = fromAssetValue.timestamp;
    } else {
      forexTimestamp = toAssetValue.timestamp;
    }

    return Forex(
      fromCurrency: fromCode,
      toCurrency: toCode,
      rate: toAssetValue.value / fromAssetValue.value,
      timestamp: forexTimestamp,
    );
  }

  Future<AssetValue> _getCachedDollarValue(Session session, {required String code}) async {
    AssetValue? dollarValue = await session.caches.local.get(code);
    if (dollarValue == null) {
      dollarValue = await forexValuesSource.getDollarValue(code: code);
      await session.caches.local.put(code, dollarValue, lifetime: Duration(seconds: 30));
    }
    return dollarValue;
  }

  Future<AssetValue> _getCachedEodDollarValue(Session session, {required String code, required DateTime date}) async {
    final cacheKey = "$code-${date.year}-${date.month}-${date.day}";
    AssetValue? dollarValue = await session.caches.local.get(cacheKey);
    if (dollarValue == null) {
      dollarValue = await forexValuesSource.getDollarValue(code: code);
      await session.caches.local.put(cacheKey, dollarValue, lifetime: Duration(days: 1));
    }
    return dollarValue;
  }
}

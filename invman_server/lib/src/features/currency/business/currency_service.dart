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
    required int? fromId,
    required int? toId,
  }) async {
    if (fromId == null && toId == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    final fromCurrency = await retrieve(session, fromId!);
    final toCurrency = await retrieve(session, toId!);

    final fromCurrencyDollarValue = await _getCachedDollarValue(session, code: fromCurrency.code);
    final toCurrencyDollarValue = await _getCachedDollarValue(session, code: toCurrency.code);

    if (toCurrencyDollarValue.value == 0) {
      throw ServerException(errorCode: ErrorCode.unknown);
    }

    final DateTime forexTimestamp;
    if (toCurrency.code == "USD") {
      forexTimestamp = fromCurrencyDollarValue.timestamp;
    } else {
      forexTimestamp = toCurrencyDollarValue.timestamp;
    }

    return Forex(
      fromCurrency: fromCurrency.code,
      toCurrency: toCurrency.code,
      rate: toCurrencyDollarValue.value / fromCurrencyDollarValue.value,
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
}

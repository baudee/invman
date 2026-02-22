import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/currency/currency.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class CurrencyService {
  final CurrencyCurrentValuesSource currentValuesSource;
  CurrencyService(this.currentValuesSource);

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

    // Last update is more than X day ago, update the value
    if (currency.updatedAt.isBefore(DateTime.now().subtract(const Duration(days: cacheDurationDays)))) {
      final (double currentValue, DateTime timestamp) = await currentValuesSource.getCurrentValue(currency.code);

      currency = await Currency.db.updateRow(
        session,
        currency.copyWith(
          dollarValue: currentValue,
          timestamp: timestamp,
          updatedAt: DateTime.now(),
        ),
        transaction: transaction,
      );
    }

    return currency;
  }

  Future<double> change(
    Session session, {
    required int? fromId,
    required int? toId,
  }) async {
    if (fromId == null && toId == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    final fromCurrency = await retrieve(session, fromId!);
    final toCurrency = await retrieve(session, toId!);

    final fromRate = fromCurrency.dollarValue;
    final toRate = toCurrency.dollarValue;

    if (toRate == 0) {
      throw ServerException(errorCode: ErrorCode.unknown);
    }

    return fromRate / toRate;
  }
}

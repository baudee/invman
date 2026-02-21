import 'package:injectable/injectable.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class CurrencyService {
  CurrencyService();

  Future<List<Currency>> list(Session session) async {
    return Currency.db.find(session, orderBy: (c) => c.code);
  }

  Future<Currency> retrieve(
    Session session,
    int id, {
    Transaction? transaction,
  }) async {
    final currency = await Currency.db.findById(
      session,
      id,
      transaction: transaction,
    );

    if (currency == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    return currency;
  }

  Future<double> change(
    Session session, {
    required Currency? from,
    required Currency? to,
  }) async {
    final fromRate = from?.dollarValue;
    final toRate = to?.dollarValue;

    // TEMPORARY
    return 1;

    if (fromRate == null || toRate == null  || toRate == 0) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    return fromRate / toRate;
  }
}

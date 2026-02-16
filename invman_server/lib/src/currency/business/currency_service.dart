import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
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
      include: IncludeHelpers.currencyInclude(),
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
    final fromRate = from?.rates?.firstOrNull;
    final toRate = to?.rates?.firstOrNull;

    if (fromRate == null || toRate == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    return fromRate.dollarValue / toRate.dollarValue;
  }
}

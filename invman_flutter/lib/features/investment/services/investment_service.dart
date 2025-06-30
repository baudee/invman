import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class InvestmentService {
  final Client client;

  const InvestmentService(this.client);

  Future<Either<String, InvestmentList>> list({
    required String currency,
    required int page,
    required int limit,
  }) async {
    return safeCall(() async {
      return right(await client.investment.list(currency: currency, page: page, limit: limit));
    });
  }

  Future<Either<String, Investment>> total({
    required String currency,
    required double percentageCurrencyChangeFee,
    required int page,
    required int limit,
  }) async {
    return safeCall(() async {
      return right(
          await client.investment.total(currency: currency, percentageCurrencyChangeFee: percentageCurrencyChangeFee));
    });
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@lazySingleton
class ReturnsRepository {
  final Client client;

  ReturnsRepository(this.client);

  Future<Either<String, List<InvestmentReturn>>> get(int id, {required InvestmentReturnInterval interval}) async {
    return safeCall(() async {
      return right(await client.investment.returns(id, interval: interval));
    });
  }

  Future<Either<String, List<InvestmentReturn>>> getTotal({required InvestmentReturnInterval interval}) async {
    return safeCall(() async {
      return right(await client.investment.totalReturns(interval: interval));
    });
  }
}

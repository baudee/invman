import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class InvestmentService {
  final Client client;

  const InvestmentService(this.client);

  Future<Either<String, InvestmentList>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.investment.list(limit: limit, page: page));
    });
  }
}

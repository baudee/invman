import 'package:fpdart/fpdart.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class InvestmentService {
  final Client client;

  const InvestmentService(this.client);

  Future<Either<String, List<Investment>>> list() async {
    return safeCall(() async {
      return right(await client.investment.list());
    });
  }

  Future<Either<String, Investment>> save(Investment investment) async {
    return safeCall(() async {
      return right(await client.investment.save(investment));
    });
  }

  Future<Either<String, Investment>> delete(int id) async {
    return safeCall(() async {
      return right(await client.investment.delete(id));
    });
  }

  Future<Either<String, Investment>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.investment.retrieve(id));
    });
  }
}

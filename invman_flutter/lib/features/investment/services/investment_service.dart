import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class InvestmentService {
  final Client client;

  const InvestmentService(this.client);

  Future<List<Investment>> list() async {
    return client.investment.list();
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

  Future<Investment> retrieve(int id) async {
    return client.investment.retrieve(id);
  }
}

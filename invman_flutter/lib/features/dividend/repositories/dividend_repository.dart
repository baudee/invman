import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@lazySingleton
class DividendRepository {
  final Client client;

  DividendRepository(this.client);

  Future<Either<String, List<InvestmentDividend>>> calendar() async {
    return safeCall(() async => right(await client.dividend.calendar()));
  }

  Future<Either<String, List<TotalDividendYear>>> total(int fromYear, int toYear) async {
    return safeCall(() async => right(await client.dividend.total(fromYear, toYear)));
  }
}

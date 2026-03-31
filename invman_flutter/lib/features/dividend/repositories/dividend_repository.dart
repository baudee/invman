import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@lazySingleton
class DividendRepository {
  final Client client;

  DividendRepository(this.client);

  Future<Either<String, List<ComputedDividendValue>>> calendar() async {
    return safeCall(() async => right(await client.dividend.calendar()));
  }

  Future<Either<String, List<TotalDividendYear>>> total(int fromYear, int toYear) async {
    return safeCall(() async => right(await client.dividend.total(fromYear, toYear)));
  }

  Future<Either<String, List<ComputedDividendValue>>> list({required int page, required int limit}) async {
    return safeCall(() async => right(await client.dividend.list(page: page, limit: limit)));
  }
}

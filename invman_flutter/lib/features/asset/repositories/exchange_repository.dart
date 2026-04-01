import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@lazySingleton
class ExchangeRepository {
  final Client client;

  ExchangeRepository(this.client);

  Future<Either<String, List<String>>> list() async {
    return safeCall(() async {
      return right(await client.asset.exchanges());
    });
  }
}

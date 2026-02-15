import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_client/invman_client.dart';

@injectable
class CurrencyRepository {
  final Client client;

  const CurrencyRepository(this.client);

  Future<Either<String, List<Currency>>> list() async {
    return safeCall(() async => right(await client.currency.list()));
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_client/invman_client.dart';

@lazySingleton
class CurrencyRepository {
  final Client client;
  List<Currency>? _cachedCurrencies;

  CurrencyRepository(this.client);

  Future<Either<String, List<Currency>>> list() async {
    if (_cachedCurrencies != null) {
      return right(_cachedCurrencies!);
    } else {
      final result = await safeCall(() async => right(await client.currency.list()));
      result.fold(
        (error) => null,
        (currencies) => _cachedCurrencies = currencies,
      );
      return result;
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_client/invman_client.dart';

@injectable
class CurrencyService {
  final Client client;

  const CurrencyService(this.client);

  Future<List<Currency>> list() async {
    return safeCallTest(() => client.currency.list());
  }
}

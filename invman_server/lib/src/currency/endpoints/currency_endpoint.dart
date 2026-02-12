import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/currency/currency.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CurrencyEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Currency>> list(Session session) async {
    return withMiddleware(
      session,
      () => getIt<CurrencyService>().list(session),
    );
  }
}

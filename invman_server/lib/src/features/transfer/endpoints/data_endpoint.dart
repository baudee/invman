import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/features/auth/models/user_scopes.dart';
import 'package:invman_server/src/features/transfer/transfer.dart';
import 'package:serverpod/serverpod.dart';

class DataTransferEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {UserScope.premium};

  Future<String> exportCsv(Session session) async {
    return withMiddleware(
      session,
      () => getIt<TransferCsvService>().exportCsv(session),
    );
  }

  Future<List<String>> importCsv(Session session, String csvContent) async {
    return withMiddleware(
      session,
      () => getIt<TransferCsvService>().importCsv(session, csvContent),
    );
  }
}

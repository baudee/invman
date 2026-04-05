import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/features/transfer/transfer.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<Transfer> retrieve(Session session, int id) async {
    return withMiddleware(
      session,
      () => getIt<TransferService>().retrieve(session, id),
    );
  }

  Future<Transfer> save(Session session, Transfer transfer) async {
    return withMiddleware(
      session,
      () => getIt<TransferService>().save(session, transfer),
    );
  }

  Future<Transfer> delete(Session session, int id) async {
    return withMiddleware(
      session,
      () => getIt<TransferService>().delete(session, id),
    );
  }

  Future<List<Transfer>> list(
    Session session,
    int investmentId, {
    int limit = 10,
    int page = 1,
  }) async {
    return withMiddleware(
      session,
      () => getIt<TransferService>().list(
        session,
        investmentId,
        limit: limit,
        page: page,
      ),
    );
  }

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

import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/transfer/transfer.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<Transfer> retrieve(Session session, int id) async {
    return withMiddleware(session, () => getIt<TransferService>().retrieve(session, id));
  }

  Future<Transfer> save(Session session, Transfer transfer) async {
    return withMiddleware(session, () => getIt<TransferService>().save(session, transfer));
  }

  Future<Transfer> delete(Session session, int id) async {
    return withMiddleware(session, () => getIt<TransferService>().delete(session, id));
  }
}

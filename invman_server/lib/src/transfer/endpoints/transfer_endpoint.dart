import 'package:invman_server/src/dependency_injection.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/transfer/transfer.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<TransferList> list(Session session, {int limit = 10, int page = 1}) async {
    return getIt<TransferService>().list(session, limit: limit, page: page);
  }

  Future<Transfer> retrieve(Session session, int id) async {
    return getIt<TransferService>().retrieve(session, id);
  }

  Future<Transfer> save(Session session, Transfer transfer) async {
    return getIt<TransferService>().save(session, transfer);
  }
}

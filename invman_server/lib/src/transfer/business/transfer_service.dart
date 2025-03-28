import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TransferService {

  TransferService();

  Future<TransferList> list(Session session, {int limit = 10, int page = 1}) async {
    final count = await Transfer.db.count(session);

    final results = await Transfer.db.find(
      session,
      limit: limit,
      offset: (page * limit) - limit,
    );

    return TransferList(
      count: count,
      limit: limit,
      page: page,
      results: results,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }
}

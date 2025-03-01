import 'package:invman_server/src/auth/business/auth_controller.dart';
import 'package:serverpod/serverpod.dart';

class ItemEndpoint extends Endpoint {
  Future<InvestmentList> list(Session session, {int limit = 20, int page = 1}) async {
    final userId = await AuthController.retrieveUserInfoId(session);
    return InvestmentController.list(session, userId: userId, limit: limit, page: page);
  }
}

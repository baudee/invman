import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/features/dividend/dividend.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class DividendEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<ComputedDividendValue>> list(Session session, {int limit = 10, int page = 1}) async {
    return withMiddleware(
      session,
      () => getIt<DividendService>().list(session, limit: limit, page: page),
    );
  }

  Future<List<InvestmentDividend>> calendar(Session session) async {
    return withMiddleware(
      session,
      () => getIt<DividendService>().calendar(session),
    );
  }

  Future<List<TotalDividendYear>> total(Session session, int fromYear, int toYear) async {
    return withMiddleware(
      session,
      () => getIt<DividendService>().total(session, fromYear, toYear),
    );
  }
}

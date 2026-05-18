import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/features/transfer/transfer.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class DataTransferEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<String> exportCsv(Session session) async {
    return withMiddleware(session, () async {
      await _requirePremium(session);
      return getIt<TransferCsvService>().exportCsv(session);
    });
  }

  Future<TransferImportPreview> parseImportPreview(Session session, String csvContent) async {
    return withMiddleware(session, () async {
      await _requirePremium(session);
      return getIt<TransferCsvService>().parseImportPreview(session, csvContent);
    });
  }

  Future<void> confirmImport(Session session, List<TransferImportRow> rows) async {
    return withMiddleware(session, () async {
      await _requirePremium(session);
      return getIt<TransferCsvService>().confirmImport(session, rows);
    });
  }

  Future<String> downloadTemplate(Session session) async {
    return withMiddleware(session, () async {
      await _requirePremium(session);
      return getIt<TransferCsvService>().template();
    });
  }

  Future<void> _requirePremium(Session session) async {
    final authUserId = (session.authenticated)!.authUserId;
    final account = await Account.db.findFirstRow(
      session,
      where: (a) => a.userId.equals(authUserId),
    );
    if (account == null || account.subscriptionPlan == SubscriptionPlan.free) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }
  }
}

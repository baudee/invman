import 'package:injectable/injectable.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

@injectable
class AppSettingsService {
  Future<AppSettings> get(Session session) async {
    final result = await AppSettings.db.find(session, limit: 1);
    final settings = result.firstOrNull;

    if (settings == null) {
      throw ServerException(
        errorCode: ErrorCode.notFound,
        message: 'AppSettings not configured',
      );
    }

    return settings;
  }
}

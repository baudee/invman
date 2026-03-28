import 'package:invman_server/src/features/app_settings/app_settings.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AppSettingsEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => false;

  Future<AppSettings> get(Session session) async {
    return withMiddleware(
      session,
      () => getIt<AppSettingsService>().get(session),
    );
  }
}

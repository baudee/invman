import 'package:invman_server/src/auth/business/auth_service.dart';
import 'package:invman_server/src/dependency_injection.dart';
import 'package:serverpod/serverpod.dart';

class AuthEndpoint extends Endpoint {
  Future<bool> isEmailAvailable(Session session, {required String email}) async {
    return getIt<AuthService>().isEmailAvailable(session, email);
  }
}

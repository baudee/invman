import 'package:invman_server/src/auth/business/auth_controller.dart';
import 'package:serverpod/serverpod.dart';

class AuthEndpoint extends Endpoint {
  Future<bool> isEmailAvailable(Session session, {required String email}) async {
    return AuthController.isEmailAvailable(session, email);
  }
}

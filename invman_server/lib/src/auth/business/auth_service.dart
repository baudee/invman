import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class AuthService {
  Future<bool> isEmailAvailable(Session session, String email) async {
    final user = await UserInfo.db.findFirstRow(
      session,
      where: (row) => row.email.equals(
        email.trim(),
      ),
    );

    return user == null;
  }
}

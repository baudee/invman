import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

abstract final class AuthController {
  static Future<bool> isEmailAvailable(Session session, String email) async {
    final user = await UserInfo.db.findFirstRow(
      session,
      where: (row) => row.email.equals(
        email.trim(),
      ),
    );

    return user == null;
  }

  static Future<int> retrieveUserInfoId(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) {
      throw AccessDeniedException(message: 'Not authenticated');
    }

    return userInfo.userId;
  }
}

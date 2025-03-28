import 'package:fpdart/fpdart.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:invman_client/invman_client.dart';

class AuthService {
  final Client client;
  final SessionManager sessionManager;

  const AuthService(this.client, this.sessionManager);

  Either<String, UserInfo?> currentUser() {
    try {
      return right(sessionManager.signedInUser);
    } on ServerException catch (e) {
      return left(e.errorCode.message);
    } catch (e, st) {
      // TODO Log to sentry
      return left(ErrorCode.unknown.message);
    }
  }

  Future<Either<String, UserInfo>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      final result = await client.modules.auth.email.authenticate(email, password);

      if (!result.success) {
        return left(ErrorCode.invalidCredentials.message);
      }

      if (result.userInfo == null || result.keyId == null || result.key == null) {
        // Log to sentry if necessary
        return left(ErrorCode.unknown.message);
      }

      await sessionManager.registerSignedInUser(
        result.userInfo!,
        result.keyId!,
        result.key!,
      );

      return right(result.userInfo!);
    });
  }

  Future<Either<String, void>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      final result = await client.modules.auth.email.createAccountRequest(email, email, password);
      if (!result) {
        return left(ErrorCode.unknown.message);
      }
      return right(null);
    });
  }

  Future<Either<String, UserInfo>> confirmEmailRegister({
    required String email,
    required String verificationCode,
    required String password,
  }) async {
    return safeCall(() async {
      final result = await client.modules.auth.email.createAccount(email, verificationCode);
      if (result == null) {
        return left(ErrorCode.unknown.message);
      }

      return await loginWithEmail(email: email, password: password);
    });
  }

  Future<Either<String, bool>> emailIsAvailable(String email) async {
    return safeCall(() async {
      final result = await client.auth.isEmailAvailable(email: email);
      return right(result);
    });
  }

  Future<Either<String, void>> initiatePasswordReset(String email) async {
    return safeCall(() async {
      final success = await client.modules.auth.email.initiatePasswordReset(email);
      if (success) {
        return right(null);
      }
      return left(ErrorCode.unknown.message);
    });
  }

  Future<Either<String, UserInfo>> completePasswordReset(
    String verificationCode,
    String newPassword,
    String email,
  ) async {
    return safeCall(() async {
      final success = await client.modules.auth.email.resetPassword(verificationCode, newPassword);
      if (success) {
        return await loginWithEmail(email: email, password: newPassword);
      }
      return left(ErrorCode.unknown.message);
    });
  }

  Future<Either<String, void>> logout() async {
    return safeCall(() async {
      await sessionManager.signOutDevice();
      return right(null);
    });
  }
}

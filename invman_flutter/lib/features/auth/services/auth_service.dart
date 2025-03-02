import 'package:fpdart/fpdart.dart';
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
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }

  Future<Either<String, UserInfo>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await client.modules.auth.email.authenticate(email, password);

      if (!result.success) {
        return left("Incorrect email or password.");
      }

      if (result.userInfo == null) {
        return left("User info null.");
      }

      if (result.keyId == null || result.key == null) {
        return left("No authentication token found");
      }

      await sessionManager.registerSignedInUser(
        result.userInfo!,
        result.keyId!,
        result.key!,
      );

      return right(result.userInfo!);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }

  Future<Either<String, void>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await client.modules.auth.email.createAccountRequest(email, email, password);
      if (!result) {
        return left("Could not create account.");
      }
      return right(null);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }

  Future<Either<String, UserInfo>> confirmEmailRegister({
    required String email,
    required String verificationCode,
    required String password,
  }) async {
    try {
      final result = await client.modules.auth.email.createAccount(email, verificationCode);
      if (result == null) {
        return left("Could not create account.");
      }

      return await loginWithEmail(email: email, password: password);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }

  Future<bool> emailIsAvailable(String email) async {
    try {
      return await client.auth.isEmailAvailable(email: email);
    } catch (e) {
      return false;
    }
  }

  Future<Either<String, void>> initiatePasswordReset(String email) async {
    try {
      final success = await client.modules.auth.email.initiatePasswordReset(email);
      if (success) {
        return right(null);
      }
      return left("Something went wrong!");
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, UserInfo>> completePasswordReset(
      String verificationCode, String newPassword, String email) async {
    try {
      final success = await client.modules.auth.email.resetPassword(verificationCode, newPassword);
      if (success) {
        return await loginWithEmail(email: email, password: newPassword);
      }
      return left("Something went wrong!");
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> logout() async {
    try {
      await sessionManager.signOutDevice();
      return right(null);
    } catch (e, st) {
      print(e);
      print(st);
      return left(e.toString());
    }
  }
}

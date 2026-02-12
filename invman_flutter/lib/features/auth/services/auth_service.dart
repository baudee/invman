import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:invman_client/invman_client.dart';

@injectable
class AuthService {
  final Client client;

  const AuthService(this.client);

  Future<Either<String, UuidValue?>> currentUser() async {
    return safeCall(() async {
      AuthSuccess? authInfo = client.auth.authInfo;
      return right(authInfo?.authUserId);
    });
  }

  Future<Either<String, void>> logout() async {
    return safeCall(() async {
      await client.auth.signOutDevice();
      return right(null);
    });
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

part 'session_manager_provider.g.dart';

@Riverpod(keepAlive: true)
SessionManager sessionManager(SessionManagerRef ref) {
  return SessionManager(caller: ref.read(clientProvider).modules.auth);
}

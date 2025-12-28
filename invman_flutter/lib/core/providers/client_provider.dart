import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_client/invman_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:invman_flutter/env.dart';

part 'client_provider.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  return Client(Env().baseUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
}

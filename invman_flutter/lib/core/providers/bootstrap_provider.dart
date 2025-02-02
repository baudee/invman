import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/auth/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bootstrap_provider.g.dart';

@Riverpod(keepAlive: true)
class Bootstrap extends _$Bootstrap {
  @override
  bool build() {
    bootstrapApp();
    return true;
  }

  Future<void> bootstrapApp() async {
    await ref.read(authProvider.notifier).init();
    await ref.read(clientProvider).openStreamingConnection();
    await ref.read(storageProvider).init();

    state = false;
  }
}

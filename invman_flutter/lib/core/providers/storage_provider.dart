import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/core/services/storage_client.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
StorageClient storage(Ref ref) {
  return StorageClientSharedPrefsImpl();
}

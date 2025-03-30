import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final transferServiceProvider = Provider<TransferService>(
  (ref) {
    return TransferService(ref.read(clientProvider));
  },
);

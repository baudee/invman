import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

final transferServiceProvider = Provider<TransferService>(
  (ref) {
    return TransferService(ref.read(clientProvider));
  },
);

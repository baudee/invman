import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

final withdrawalFeeServiceProvider = Provider<WithdrawalFeeService>(
  (ref) {
    return WithdrawalFeeService(ref.read(clientProvider));
  },
);

import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final withdrawalFeeServiceProvider = Provider<WithdrawalFeeService>(
  (ref) {
    return WithdrawalFeeService(ref.read(clientProvider));
  },
);

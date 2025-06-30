import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final withdrawalRuleServiceProvider = Provider<WithdrawalRuleService>(
  (ref) {
    return WithdrawalRuleService(ref.read(clientProvider));
  },
);

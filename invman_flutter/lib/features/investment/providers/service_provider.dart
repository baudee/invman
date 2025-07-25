import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final investmentServiceProvider = Provider<InvestmentService>(
  (ref) {
    return InvestmentService(ref.read(clientProvider));
  },
);

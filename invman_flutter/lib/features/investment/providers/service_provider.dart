import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/investment/investment.dart';

final investmentServiceProvider = Provider<InvestmentService>(
  (ref) {
    return InvestmentService(ref.read(clientProvider));
  },
);

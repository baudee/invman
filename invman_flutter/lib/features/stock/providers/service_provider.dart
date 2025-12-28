import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/stock/stock.dart';

final stockServiceProvider = Provider<StockService>(
  (ref) {
    return StockService(ref.read(clientProvider));
  },
);

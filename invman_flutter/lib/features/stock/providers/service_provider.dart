import 'package:invman_flutter/core/providers/client_provider.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final stockServiceProvider = Provider<StockService>(
  (ref) {
    return StockService(ref.read(clientProvider));
  },
);

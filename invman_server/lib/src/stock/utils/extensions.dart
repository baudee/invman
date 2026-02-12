import 'package:invman_server/src/generated/protocol.dart';

extension StockExtension on Stock {
  double get currentPrice => prices?.firstOrNull?.value ?? 0.0;
}

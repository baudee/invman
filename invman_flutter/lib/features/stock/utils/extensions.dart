import 'package:invman_client/invman_client.dart';

extension StockExtension on Stock {
  double get currentPrice => prices?.firstOrNull?.value ?? 0.0;
}

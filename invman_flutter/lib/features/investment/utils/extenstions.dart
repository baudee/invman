import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

extension ForexExtension on Forex {
  String toStringComparison() {
    if (rate < 1) {
      return "1 $toCurrency = ${(1 / rate).toStringPrice(fromCurrency)}";
    } else {
      return "1 $fromCurrency = ${rate.toStringPrice(toCurrency)}";
    }
  }
}

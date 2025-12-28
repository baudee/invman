extension DoubleExtension on double {
  String toStringPrice(String currency) {
    return "${toStringAsFixed(1)} $currency";
  }
}

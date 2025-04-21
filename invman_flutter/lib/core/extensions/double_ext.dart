extension DoubleExtension on double {
  String toStringPrice(String currency) {
    return "${toStringAsFixed(2)} $currency";
  }
}

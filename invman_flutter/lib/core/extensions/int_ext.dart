extension StringPrice on int {
  String toStringPrice(String currency) {
    final doublePrice = this / 100;
    return "${doublePrice.toStringAsFixed(2)} $currency";
  }
}

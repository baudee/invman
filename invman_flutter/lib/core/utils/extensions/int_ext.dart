extension IntExtension on int? {
  String toStringPrice(String currency) {
    if (this == null) {
      return "- $currency";
    }
    final doublePrice = this! / 100;
    return "${doublePrice.toStringAsFixed(2)} $currency";
  }
}

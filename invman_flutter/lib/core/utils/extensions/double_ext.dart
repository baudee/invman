extension DoubleExtension on double {
  String toStringPrice(String? currencyCode) {
    return "${toStringAsFixed(2)} ${currencyCode ?? '-'}";
  }
}

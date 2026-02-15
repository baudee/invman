extension DoubleExtension on double {
  String toStringPrice(String? currencyCode) {
    return "${toStringAsFixed(1)} ${currencyCode ?? '-'}";
  }
}

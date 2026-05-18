extension DoubleExtension on double? {
  String toStringPrice(String? currencyCode) {
    if (this == null) {
      return '-';
    }
    return "${this!.toStringAsFixed(1)} ${currencyCode ?? '-'}";
  }
}

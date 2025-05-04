extension TextPriceExtension on String {
  int? toIntPrice() {
    double? price = double.tryParse(trim());
    if (price == null) {
      return null;
    } else {
      return (price * 100).toInt();
    }
  }
} 

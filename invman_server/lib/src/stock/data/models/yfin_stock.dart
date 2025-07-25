import 'package:invman_server/src/generated/protocol.dart';

class YFinStock {
  final String symbol;
  final String longName;
  final double regularMarketPrice;
  final String currency;
  final String quoteType;

  YFinStock({
    required this.symbol,
    required this.longName,
    required this.regularMarketPrice,
    required this.currency,
    required this.quoteType,
  });

  factory YFinStock.fromJson(Map<String, dynamic> json) {
    return YFinStock(
      symbol: json['symbol'],
      longName: json['longName'] ?? "No Name",
      regularMarketPrice: (json['regularMarketPrice'] as num).toDouble(),
      currency: json['currency'],
      quoteType: json['quoteType'],
    );
  }

  Stock toEntity() {
    return Stock(
      symbol: symbol,
      currency: currency.toUpperCase(),
      name: longName,
      value: regularMarketPrice,
      quoteType: quoteType,
    );
  }
}

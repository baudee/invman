import 'package:invman_server/src/generated/protocol.dart';

class YFinLightStock {
  final String quoteType;
  final String symbol;
  final String longName;
  final bool isYahooFinance;

  YFinLightStock({
    required this.quoteType,
    required this.symbol,
    required this.longName,
    required this.isYahooFinance,
  });

  Stock toEntity() {
    return Stock(
      quoteType: quoteType,
      symbol: symbol,
      currency: '',
      name: longName,
      value: -1.0,
    );
  }

  factory YFinLightStock.fromJson(Map<String, dynamic> json) {
    return YFinLightStock(
      quoteType: json['quoteType'] ?? '',
      symbol: json['symbol'] ?? '',
      longName: json['longname'] ?? '',
      isYahooFinance: json['isYahooFinance'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quoteType': quoteType,
      'symbol': symbol,
      'longname': longName,
      'isYahooFinance': isYahooFinance,
    };
  }
}

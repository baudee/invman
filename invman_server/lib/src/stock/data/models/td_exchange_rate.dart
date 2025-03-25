class TwelveDataExchangeRate {
  final String symbol;
  final double rate;
  final int timestamp;

  TwelveDataExchangeRate({
    required this.symbol,
    required this.rate,
    required this.timestamp,
  });

  factory TwelveDataExchangeRate.fromJson(Map<String, dynamic> json) {
    return TwelveDataExchangeRate(
      symbol: json['symbol'],
      rate: (json['rate'] as num).toDouble(),
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'rate': rate,
      'timestamp': timestamp,
    };
  }
}

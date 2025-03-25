import 'package:invman_server/src/generated/protocol.dart';

class StockInfo {
  final String symbol;
  final String instrumentName;
  final String exchange;
  final String micCode;
  final String exchangeTimezone;
  final String instrumentType;
  final String country;
  final String currency;

  StockInfo({
    required this.symbol,
    required this.instrumentName,
    required this.exchange,
    required this.micCode,
    required this.exchangeTimezone,
    required this.instrumentType,
    required this.country,
    required this.currency,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      symbol: json['symbol'],
      instrumentName: json['instrument_name'],
      exchange: json['exchange'],
      micCode: json['mic_code'],
      exchangeTimezone: json['exchange_timezone'],
      instrumentType: json['instrument_type'],
      country: json['country'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'instrument_name': instrumentName,
      'exchange': exchange,
      'mic_code': micCode,
      'exchange_timezone': exchangeTimezone,
      'instrument_type': instrumentType,
      'country': country,
      'currency': currency,
    };
  }

  Stock toStock() {
    return Stock(
      symbol: symbol,
      currency: currency,
      name: instrumentName,
    );
  }
}

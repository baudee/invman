/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Stock implements _i1.SerializableModel {
  Stock._({
    required this.symbol,
    required this.name,
    required this.value,
    required this.currency,
    required this.quoteType,
  });

  factory Stock({
    required String symbol,
    required String name,
    required double value,
    required String currency,
    required String quoteType,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      quoteType: jsonSerialization['quoteType'] as String,
    );
  }

  String symbol;

  String name;

  double value;

  String currency;

  String quoteType;

  Stock copyWith({
    String? symbol,
    String? name,
    double? value,
    String? currency,
    String? quoteType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'value': value,
      'currency': currency,
      'quoteType': quoteType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _StockImpl extends Stock {
  _StockImpl({
    required String symbol,
    required String name,
    required double value,
    required String currency,
    required String quoteType,
  }) : super._(
          symbol: symbol,
          name: name,
          value: value,
          currency: currency,
          quoteType: quoteType,
        );

  @override
  Stock copyWith({
    String? symbol,
    String? name,
    double? value,
    String? currency,
    String? quoteType,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      quoteType: quoteType ?? this.quoteType,
    );
  }
}

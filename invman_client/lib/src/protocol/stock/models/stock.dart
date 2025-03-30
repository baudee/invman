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
    this.id,
    required this.symbol,
    required this.name,
    double? value,
    required this.currency,
    required this.stockExchange,
    required this.exchangeShortName,
  }) : value = value ?? 0.0;

  factory Stock({
    int? id,
    required String symbol,
    required String name,
    double? value,
    required String currency,
    required String stockExchange,
    required String exchangeShortName,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      id: jsonSerialization['id'] as int?,
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      stockExchange: jsonSerialization['stockExchange'] as String,
      exchangeShortName: jsonSerialization['exchangeShortName'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String symbol;

  String name;

  double value;

  String currency;

  String stockExchange;

  String exchangeShortName;

  Stock copyWith({
    int? id,
    String? symbol,
    String? name,
    double? value,
    String? currency,
    String? stockExchange,
    String? exchangeShortName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'symbol': symbol,
      'name': name,
      'value': value,
      'currency': currency,
      'stockExchange': stockExchange,
      'exchangeShortName': exchangeShortName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockImpl extends Stock {
  _StockImpl({
    int? id,
    required String symbol,
    required String name,
    double? value,
    required String currency,
    required String stockExchange,
    required String exchangeShortName,
  }) : super._(
          id: id,
          symbol: symbol,
          name: name,
          value: value,
          currency: currency,
          stockExchange: stockExchange,
          exchangeShortName: exchangeShortName,
        );

  @override
  Stock copyWith({
    Object? id = _Undefined,
    String? symbol,
    String? name,
    double? value,
    String? currency,
    String? stockExchange,
    String? exchangeShortName,
  }) {
    return Stock(
      id: id is int? ? id : this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      stockExchange: stockExchange ?? this.stockExchange,
      exchangeShortName: exchangeShortName ?? this.exchangeShortName,
    );
  }
}

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../stock/models/stock_type.dart' as _i2;
import '../../currency/models/currency.dart' as _i3;
import '../../stock/models/stock_price.dart' as _i4;
import 'package:invman_client/src/protocol/protocol.dart' as _i5;

abstract class Stock implements _i1.SerializableModel {
  Stock._({
    _i1.UuidValue? id,
    required this.symbol,
    required this.shortName,
    required this.longName,
    required this.quoteType,
    required this.currencyId,
    this.currency,
    this.prices,
  }) : id = id ?? _i1.Uuid().v4obj();

  factory Stock({
    _i1.UuidValue? id,
    required String symbol,
    required String shortName,
    required String longName,
    required _i2.StockType quoteType,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockPrice>? prices,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      symbol: jsonSerialization['symbol'] as String,
      shortName: jsonSerialization['shortName'] as String,
      longName: jsonSerialization['longName'] as String,
      quoteType: _i2.StockType.fromJson(
        (jsonSerialization['quoteType'] as String),
      ),
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
      prices: jsonSerialization['prices'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.StockPrice>>(
              jsonSerialization['prices'],
            ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String symbol;

  String shortName;

  String longName;

  _i2.StockType quoteType;

  int currencyId;

  _i3.Currency? currency;

  List<_i4.StockPrice>? prices;

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? shortName,
    String? longName,
    _i2.StockType? quoteType,
    int? currencyId,
    _i3.Currency? currency,
    List<_i4.StockPrice>? prices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stock',
      'id': id.toJson(),
      'symbol': symbol,
      'shortName': shortName,
      'longName': longName,
      'quoteType': quoteType.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      if (prices != null)
        'prices': prices?.toJson(valueToJson: (v) => v.toJson()),
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
    _i1.UuidValue? id,
    required String symbol,
    required String shortName,
    required String longName,
    required _i2.StockType quoteType,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockPrice>? prices,
  }) : super._(
         id: id,
         symbol: symbol,
         shortName: shortName,
         longName: longName,
         quoteType: quoteType,
         currencyId: currencyId,
         currency: currency,
         prices: prices,
       );

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? shortName,
    String? longName,
    _i2.StockType? quoteType,
    int? currencyId,
    Object? currency = _Undefined,
    Object? prices = _Undefined,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      shortName: shortName ?? this.shortName,
      longName: longName ?? this.longName,
      quoteType: quoteType ?? this.quoteType,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i3.Currency?
          ? currency
          : this.currency?.copyWith(),
      prices: prices is List<_i4.StockPrice>?
          ? prices
          : this.prices?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

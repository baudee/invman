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
import '../../stock/models/stock_like.dart' as _i4;
import 'package:invman_client/src/protocol/protocol.dart' as _i5;

abstract class Stock implements _i1.SerializableModel {
  Stock._({
    _i1.UuidValue? id,
    required this.symbol,
    required this.name,
    required this.quoteType,
    this.logoUrl,
    double? price,
    DateTime? updatedAt,
    required this.currencyId,
    this.currency,
    this.likes,
  }) : id = id ?? _i1.Uuid().v4obj(),
       price = price ?? 0.0,
       updatedAt = updatedAt ?? DateTime.now();

  factory Stock({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    required _i2.StockType quoteType,
    String? logoUrl,
    double? price,
    DateTime? updatedAt,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockLike>? likes,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      quoteType: _i2.StockType.fromJson(
        (jsonSerialization['quoteType'] as String),
      ),
      logoUrl: jsonSerialization['logoUrl'] as String?,
      price: (jsonSerialization['price'] as num?)?.toDouble(),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
      likes: jsonSerialization['likes'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.StockLike>>(
              jsonSerialization['likes'],
            ),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String symbol;

  String name;

  _i2.StockType quoteType;

  String? logoUrl;

  double price;

  DateTime updatedAt;

  int currencyId;

  _i3.Currency? currency;

  List<_i4.StockLike>? likes;

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    _i2.StockType? quoteType,
    String? logoUrl,
    double? price,
    DateTime? updatedAt,
    int? currencyId,
    _i3.Currency? currency,
    List<_i4.StockLike>? likes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stock',
      'id': id.toJson(),
      'symbol': symbol,
      'name': name,
      'quoteType': quoteType.toJson(),
      if (logoUrl != null) 'logoUrl': logoUrl,
      'price': price,
      'updatedAt': updatedAt.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      if (likes != null) 'likes': likes?.toJson(valueToJson: (v) => v.toJson()),
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
    required String name,
    required _i2.StockType quoteType,
    String? logoUrl,
    double? price,
    DateTime? updatedAt,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.StockLike>? likes,
  }) : super._(
         id: id,
         symbol: symbol,
         name: name,
         quoteType: quoteType,
         logoUrl: logoUrl,
         price: price,
         updatedAt: updatedAt,
         currencyId: currencyId,
         currency: currency,
         likes: likes,
       );

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Stock copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    _i2.StockType? quoteType,
    Object? logoUrl = _Undefined,
    double? price,
    DateTime? updatedAt,
    int? currencyId,
    Object? currency = _Undefined,
    Object? likes = _Undefined,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      quoteType: quoteType ?? this.quoteType,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i3.Currency?
          ? currency
          : this.currency?.copyWith(),
      likes: likes is List<_i4.StockLike>?
          ? likes
          : this.likes?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

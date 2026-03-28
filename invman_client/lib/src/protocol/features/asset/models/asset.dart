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
import '../../../features/asset/models/asset_type.dart' as _i2;
import '../../../features/currency/models/currency.dart' as _i3;
import '../../../features/asset/models/asset_like.dart' as _i4;
import '../../../features/investment/models/investment.dart' as _i5;
import 'package:invman_client/src/protocol/protocol.dart' as _i6;

abstract class Asset implements _i1.SerializableModel {
  Asset._({
    _i1.UuidValue? id,
    required this.symbol,
    required this.name,
    this.exchange,
    required this.type,
    this.logoUrl,
    required this.currencyId,
    this.currency,
    this.likes,
    this.investments,
    this.price,
    this.timestamp,
  }) : id = id ?? const _i1.Uuid().v4obj();

  factory Asset({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    String? exchange,
    required _i2.AssetType type,
    String? logoUrl,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.AssetLike>? likes,
    List<_i5.Investment>? investments,
    double? price,
    DateTime? timestamp,
  }) = _AssetImpl;

  factory Asset.fromJson(Map<String, dynamic> jsonSerialization) {
    return Asset(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      exchange: jsonSerialization['exchange'] as String?,
      type: _i2.AssetType.fromJson((jsonSerialization['type'] as String)),
      logoUrl: jsonSerialization['logoUrl'] as String?,
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Currency>(
              jsonSerialization['currency'],
            ),
      likes: jsonSerialization['likes'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.AssetLike>>(
              jsonSerialization['likes'],
            ),
      investments: jsonSerialization['investments'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.Investment>>(
              jsonSerialization['investments'],
            ),
      price: (jsonSerialization['price'] as num?)?.toDouble(),
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  /// The id of the object.
  _i1.UuidValue id;

  String symbol;

  String name;

  String? exchange;

  _i2.AssetType type;

  String? logoUrl;

  int currencyId;

  _i3.Currency? currency;

  List<_i4.AssetLike>? likes;

  List<_i5.Investment>? investments;

  double? price;

  DateTime? timestamp;

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Asset copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    String? exchange,
    _i2.AssetType? type,
    String? logoUrl,
    int? currencyId,
    _i3.Currency? currency,
    List<_i4.AssetLike>? likes,
    List<_i5.Investment>? investments,
    double? price,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Asset',
      'id': id.toJson(),
      'symbol': symbol,
      'name': name,
      if (exchange != null) 'exchange': exchange,
      'type': type.toJson(),
      if (logoUrl != null) 'logoUrl': logoUrl,
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      if (likes != null) 'likes': likes?.toJson(valueToJson: (v) => v.toJson()),
      if (investments != null)
        'investments': investments?.toJson(valueToJson: (v) => v.toJson()),
      if (price != null) 'price': price,
      if (timestamp != null) 'timestamp': timestamp?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetImpl extends Asset {
  _AssetImpl({
    _i1.UuidValue? id,
    required String symbol,
    required String name,
    String? exchange,
    required _i2.AssetType type,
    String? logoUrl,
    required int currencyId,
    _i3.Currency? currency,
    List<_i4.AssetLike>? likes,
    List<_i5.Investment>? investments,
    double? price,
    DateTime? timestamp,
  }) : super._(
         id: id,
         symbol: symbol,
         name: name,
         exchange: exchange,
         type: type,
         logoUrl: logoUrl,
         currencyId: currencyId,
         currency: currency,
         likes: likes,
         investments: investments,
         price: price,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Asset copyWith({
    _i1.UuidValue? id,
    String? symbol,
    String? name,
    Object? exchange = _Undefined,
    _i2.AssetType? type,
    Object? logoUrl = _Undefined,
    int? currencyId,
    Object? currency = _Undefined,
    Object? likes = _Undefined,
    Object? investments = _Undefined,
    Object? price = _Undefined,
    Object? timestamp = _Undefined,
  }) {
    return Asset(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      exchange: exchange is String? ? exchange : this.exchange,
      type: type ?? this.type,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i3.Currency?
          ? currency
          : this.currency?.copyWith(),
      likes: likes is List<_i4.AssetLike>?
          ? likes
          : this.likes?.map((e0) => e0.copyWith()).toList(),
      investments: investments is List<_i5.Investment>?
          ? investments
          : this.investments?.map((e0) => e0.copyWith()).toList(),
      price: price is double? ? price : this.price,
      timestamp: timestamp is DateTime? ? timestamp : this.timestamp,
    );
  }
}

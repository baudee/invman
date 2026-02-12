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
import '../../stock/models/stock.dart' as _i2;
import 'package:invman_client/src/protocol/protocol.dart' as _i3;

abstract class StockPrice implements _i1.SerializableModel {
  StockPrice._({
    this.id,
    required this.value,
    required this.timestamp,
    required this.stockId,
    this.stock,
  });

  factory StockPrice({
    int? id,
    required double value,
    required DateTime timestamp,
    required _i1.UuidValue stockId,
    _i2.Stock? stock,
  }) = _StockPriceImpl;

  factory StockPrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockPrice(
      id: jsonSerialization['id'] as int?,
      value: (jsonSerialization['value'] as num).toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      stockId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['stockId'],
      ),
      stock: jsonSerialization['stock'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Stock>(jsonSerialization['stock']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  double value;

  DateTime timestamp;

  _i1.UuidValue stockId;

  _i2.Stock? stock;

  /// Returns a shallow copy of this [StockPrice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StockPrice copyWith({
    int? id,
    double? value,
    DateTime? timestamp,
    _i1.UuidValue? stockId,
    _i2.Stock? stock,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockPrice',
      if (id != null) 'id': id,
      'value': value,
      'timestamp': timestamp.toJson(),
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockPriceImpl extends StockPrice {
  _StockPriceImpl({
    int? id,
    required double value,
    required DateTime timestamp,
    required _i1.UuidValue stockId,
    _i2.Stock? stock,
  }) : super._(
         id: id,
         value: value,
         timestamp: timestamp,
         stockId: stockId,
         stock: stock,
       );

  /// Returns a shallow copy of this [StockPrice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StockPrice copyWith({
    Object? id = _Undefined,
    double? value,
    DateTime? timestamp,
    _i1.UuidValue? stockId,
    Object? stock = _Undefined,
  }) {
    return StockPrice(
      id: id is int? ? id : this.id,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      stockId: stockId ?? this.stockId,
      stock: stock is _i2.Stock? ? stock : this.stock?.copyWith(),
    );
  }
}

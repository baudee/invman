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

abstract class Stock implements _i1.SerializableModel {
  Stock._({
    this.id,
    required this.symbol,
    required this.name,
    required this.value,
    required this.currency,
    required this.quoteType,
    required this.updatedAt,
  });

  factory Stock({
    int? id,
    required String symbol,
    required String name,
    required double value,
    required String currency,
    required String quoteType,
    required DateTime updatedAt,
  }) = _StockImpl;

  factory Stock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stock(
      id: jsonSerialization['id'] as int?,
      symbol: jsonSerialization['symbol'] as String,
      name: jsonSerialization['name'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      quoteType: jsonSerialization['quoteType'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
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

  String quoteType;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Stock copyWith({
    int? id,
    String? symbol,
    String? name,
    double? value,
    String? currency,
    String? quoteType,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stock',
      if (id != null) 'id': id,
      'symbol': symbol,
      'name': name,
      'value': value,
      'currency': currency,
      'quoteType': quoteType,
      'updatedAt': updatedAt.toJson(),
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
    required double value,
    required String currency,
    required String quoteType,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         symbol: symbol,
         name: name,
         value: value,
         currency: currency,
         quoteType: quoteType,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Stock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Stock copyWith({
    Object? id = _Undefined,
    String? symbol,
    String? name,
    double? value,
    String? currency,
    String? quoteType,
    DateTime? updatedAt,
  }) {
    return Stock(
      id: id is int? ? id : this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      quoteType: quoteType ?? this.quoteType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

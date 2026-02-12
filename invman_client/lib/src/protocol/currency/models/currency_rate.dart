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
import '../../currency/models/currency.dart' as _i2;
import 'package:invman_client/src/protocol/protocol.dart' as _i3;

abstract class CurrencyRate implements _i1.SerializableModel {
  CurrencyRate._({
    this.id,
    required this.dollarValue,
    required this.timestamp,
    required this.currencyId,
    this.currency,
  });

  factory CurrencyRate({
    int? id,
    required double dollarValue,
    required DateTime timestamp,
    required int currencyId,
    _i2.Currency? currency,
  }) = _CurrencyRateImpl;

  factory CurrencyRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurrencyRate(
      id: jsonSerialization['id'] as int?,
      dollarValue: (jsonSerialization['dollarValue'] as num).toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      currencyId: jsonSerialization['currencyId'] as int,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Currency>(
              jsonSerialization['currency'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  double dollarValue;

  DateTime timestamp;

  int currencyId;

  _i2.Currency? currency;

  /// Returns a shallow copy of this [CurrencyRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurrencyRate copyWith({
    int? id,
    double? dollarValue,
    DateTime? timestamp,
    int? currencyId,
    _i2.Currency? currency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurrencyRate',
      if (id != null) 'id': id,
      'dollarValue': dollarValue,
      'timestamp': timestamp.toJson(),
      'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurrencyRateImpl extends CurrencyRate {
  _CurrencyRateImpl({
    int? id,
    required double dollarValue,
    required DateTime timestamp,
    required int currencyId,
    _i2.Currency? currency,
  }) : super._(
         id: id,
         dollarValue: dollarValue,
         timestamp: timestamp,
         currencyId: currencyId,
         currency: currency,
       );

  /// Returns a shallow copy of this [CurrencyRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurrencyRate copyWith({
    Object? id = _Undefined,
    double? dollarValue,
    DateTime? timestamp,
    int? currencyId,
    Object? currency = _Undefined,
  }) {
    return CurrencyRate(
      id: id is int? ? id : this.id,
      dollarValue: dollarValue ?? this.dollarValue,
      timestamp: timestamp ?? this.timestamp,
      currencyId: currencyId ?? this.currencyId,
      currency: currency is _i2.Currency?
          ? currency
          : this.currency?.copyWith(),
    );
  }
}

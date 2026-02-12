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
import '../../currency/models/currency_rate.dart' as _i2;
import 'package:invman_client/src/protocol/protocol.dart' as _i3;

abstract class Currency implements _i1.SerializableModel {
  Currency._({
    this.id,
    required this.code,
    this.rates,
  });

  factory Currency({
    int? id,
    required String code,
    List<_i2.CurrencyRate>? rates,
  }) = _CurrencyImpl;

  factory Currency.fromJson(Map<String, dynamic> jsonSerialization) {
    return Currency(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      rates: jsonSerialization['rates'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.CurrencyRate>>(
              jsonSerialization['rates'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  List<_i2.CurrencyRate>? rates;

  /// Returns a shallow copy of this [Currency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Currency copyWith({
    int? id,
    String? code,
    List<_i2.CurrencyRate>? rates,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Currency',
      if (id != null) 'id': id,
      'code': code,
      if (rates != null) 'rates': rates?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurrencyImpl extends Currency {
  _CurrencyImpl({
    int? id,
    required String code,
    List<_i2.CurrencyRate>? rates,
  }) : super._(
         id: id,
         code: code,
         rates: rates,
       );

  /// Returns a shallow copy of this [Currency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Currency copyWith({
    Object? id = _Undefined,
    String? code,
    Object? rates = _Undefined,
  }) {
    return Currency(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      rates: rates is List<_i2.CurrencyRate>?
          ? rates
          : this.rates?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

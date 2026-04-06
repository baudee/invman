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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class TwelveDataDividendValue implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TwelveDataDividendValue._({
    required this.exDate,
    required this.amount,
  });

  factory TwelveDataDividendValue({
    required String exDate,
    required double amount,
  }) = _TwelveDataDividendValueImpl;

  factory TwelveDataDividendValue.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TwelveDataDividendValue(
      exDate: jsonSerialization['ex_date'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
    );
  }

  String exDate;

  double amount;

  /// Returns a shallow copy of this [TwelveDataDividendValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TwelveDataDividendValue copyWith({
    String? exDate,
    double? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TwelveDataDividendValue',
      'ex_date': exDate,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TwelveDataDividendValueImpl extends TwelveDataDividendValue {
  _TwelveDataDividendValueImpl({
    required String exDate,
    required double amount,
  }) : super._(
         exDate: exDate,
         amount: amount,
       );

  /// Returns a shallow copy of this [TwelveDataDividendValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TwelveDataDividendValue copyWith({
    String? exDate,
    double? amount,
  }) {
    return TwelveDataDividendValue(
      exDate: exDate ?? this.exDate,
      amount: amount ?? this.amount,
    );
  }
}

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

abstract class ComputedDividendValue
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ComputedDividendValue._({
    required this.date,
    required this.amountPerShare,
    required this.amount,
  });

  factory ComputedDividendValue({
    required DateTime date,
    required double amountPerShare,
    required double amount,
  }) = _ComputedDividendValueImpl;

  factory ComputedDividendValue.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ComputedDividendValue(
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      amountPerShare: (jsonSerialization['amountPerShare'] as num).toDouble(),
      amount: (jsonSerialization['amount'] as num).toDouble(),
    );
  }

  DateTime date;

  double amountPerShare;

  double amount;

  /// Returns a shallow copy of this [ComputedDividendValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ComputedDividendValue copyWith({
    DateTime? date,
    double? amountPerShare,
    double? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ComputedDividendValue',
      'date': date.toJson(),
      'amountPerShare': amountPerShare,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ComputedDividendValue',
      'date': date.toJson(),
      'amountPerShare': amountPerShare,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ComputedDividendValueImpl extends ComputedDividendValue {
  _ComputedDividendValueImpl({
    required DateTime date,
    required double amountPerShare,
    required double amount,
  }) : super._(
         date: date,
         amountPerShare: amountPerShare,
         amount: amount,
       );

  /// Returns a shallow copy of this [ComputedDividendValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ComputedDividendValue copyWith({
    DateTime? date,
    double? amountPerShare,
    double? amount,
  }) {
    return ComputedDividendValue(
      date: date ?? this.date,
      amountPerShare: amountPerShare ?? this.amountPerShare,
      amount: amount ?? this.amount,
    );
  }
}

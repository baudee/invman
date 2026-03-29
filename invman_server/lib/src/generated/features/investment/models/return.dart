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

abstract class InvestmentReturn
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  InvestmentReturn._({
    required this.percentage,
    required this.gains,
    required this.year,
    required this.month,
  });

  factory InvestmentReturn({
    required double percentage,
    required double gains,
    required int year,
    required int month,
  }) = _InvestmentReturnImpl;

  factory InvestmentReturn.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvestmentReturn(
      percentage: (jsonSerialization['percentage'] as num).toDouble(),
      gains: (jsonSerialization['gains'] as num).toDouble(),
      year: jsonSerialization['year'] as int,
      month: jsonSerialization['month'] as int,
    );
  }

  double percentage;

  double gains;

  int year;

  int month;

  /// Returns a shallow copy of this [InvestmentReturn]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InvestmentReturn copyWith({
    double? percentage,
    double? gains,
    int? year,
    int? month,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvestmentReturn',
      'percentage': percentage,
      'gains': gains,
      'year': year,
      'month': month,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvestmentReturn',
      'percentage': percentage,
      'gains': gains,
      'year': year,
      'month': month,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _InvestmentReturnImpl extends InvestmentReturn {
  _InvestmentReturnImpl({
    required double percentage,
    required double gains,
    required int year,
    required int month,
  }) : super._(
         percentage: percentage,
         gains: gains,
         year: year,
         month: month,
       );

  /// Returns a shallow copy of this [InvestmentReturn]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InvestmentReturn copyWith({
    double? percentage,
    double? gains,
    int? year,
    int? month,
  }) {
    return InvestmentReturn(
      percentage: percentage ?? this.percentage,
      gains: gains ?? this.gains,
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }
}

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

abstract class TotalDividendYear
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TotalDividendYear._({
    required this.year,
    required this.total,
    required this.currency,
  });

  factory TotalDividendYear({
    required int year,
    required double total,
    required String currency,
  }) = _TotalDividendYearImpl;

  factory TotalDividendYear.fromJson(Map<String, dynamic> jsonSerialization) {
    return TotalDividendYear(
      year: jsonSerialization['year'] as int,
      total: (jsonSerialization['total'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
    );
  }

  int year;

  double total;

  String currency;

  /// Returns a shallow copy of this [TotalDividendYear]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TotalDividendYear copyWith({
    int? year,
    double? total,
    String? currency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TotalDividendYear',
      'year': year,
      'total': total,
      'currency': currency,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TotalDividendYear',
      'year': year,
      'total': total,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TotalDividendYearImpl extends TotalDividendYear {
  _TotalDividendYearImpl({
    required int year,
    required double total,
    required String currency,
  }) : super._(
         year: year,
         total: total,
         currency: currency,
       );

  /// Returns a shallow copy of this [TotalDividendYear]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TotalDividendYear copyWith({
    int? year,
    double? total,
    String? currency,
  }) {
    return TotalDividendYear(
      year: year ?? this.year,
      total: total ?? this.total,
      currency: currency ?? this.currency,
    );
  }
}

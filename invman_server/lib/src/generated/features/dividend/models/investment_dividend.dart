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
import '../../../features/investment/models/investment.dart' as _i2;
import '../../../features/dividend/models/computed_dividend_value.dart' as _i3;
import 'package:invman_server/src/generated/protocol.dart' as _i4;

abstract class InvestmentDividend
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  InvestmentDividend._({
    required this.investment,
    required this.dividends,
  });

  factory InvestmentDividend({
    required _i2.Investment investment,
    required List<_i3.ComputedDividendValue> dividends,
  }) = _InvestmentDividendImpl;

  factory InvestmentDividend.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvestmentDividend(
      investment: _i4.Protocol().deserialize<_i2.Investment>(
        jsonSerialization['investment'],
      ),
      dividends: _i4.Protocol().deserialize<List<_i3.ComputedDividendValue>>(
        jsonSerialization['dividends'],
      ),
    );
  }

  _i2.Investment investment;

  List<_i3.ComputedDividendValue> dividends;

  /// Returns a shallow copy of this [InvestmentDividend]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InvestmentDividend copyWith({
    _i2.Investment? investment,
    List<_i3.ComputedDividendValue>? dividends,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvestmentDividend',
      'investment': investment.toJson(),
      'dividends': dividends.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvestmentDividend',
      'investment': investment.toJsonForProtocol(),
      'dividends': dividends.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _InvestmentDividendImpl extends InvestmentDividend {
  _InvestmentDividendImpl({
    required _i2.Investment investment,
    required List<_i3.ComputedDividendValue> dividends,
  }) : super._(
         investment: investment,
         dividends: dividends,
       );

  /// Returns a shallow copy of this [InvestmentDividend]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InvestmentDividend copyWith({
    _i2.Investment? investment,
    List<_i3.ComputedDividendValue>? dividends,
  }) {
    return InvestmentDividend(
      investment: investment ?? this.investment.copyWith(),
      dividends:
          dividends ?? this.dividends.map((e0) => e0.copyWith()).toList(),
    );
  }
}

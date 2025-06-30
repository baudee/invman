/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../withdrawal/models/withdrawal_rule.dart' as _i2;

abstract class WithdrawalFee implements _i1.SerializableModel {
  WithdrawalFee._({
    this.id,
    double? fixed,
    double? percent,
    double? minimum,
    required this.ruleId,
    this.rule,
  })  : fixed = fixed ?? 0.0,
        percent = percent ?? 0.0,
        minimum = minimum ?? 0.0;

  factory WithdrawalFee({
    int? id,
    double? fixed,
    double? percent,
    double? minimum,
    required int ruleId,
    _i2.WithdrawalRule? rule,
  }) = _WithdrawalFeeImpl;

  factory WithdrawalFee.fromJson(Map<String, dynamic> jsonSerialization) {
    return WithdrawalFee(
      id: jsonSerialization['id'] as int?,
      fixed: (jsonSerialization['fixed'] as num).toDouble(),
      percent: (jsonSerialization['percent'] as num).toDouble(),
      minimum: (jsonSerialization['minimum'] as num).toDouble(),
      ruleId: jsonSerialization['ruleId'] as int,
      rule: jsonSerialization['rule'] == null
          ? null
          : _i2.WithdrawalRule.fromJson(
              (jsonSerialization['rule'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  double fixed;

  double percent;

  double minimum;

  int ruleId;

  _i2.WithdrawalRule? rule;

  WithdrawalFee copyWith({
    int? id,
    double? fixed,
    double? percent,
    double? minimum,
    int? ruleId,
    _i2.WithdrawalRule? rule,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'fixed': fixed,
      'percent': percent,
      'minimum': minimum,
      'ruleId': ruleId,
      if (rule != null) 'rule': rule?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WithdrawalFeeImpl extends WithdrawalFee {
  _WithdrawalFeeImpl({
    int? id,
    double? fixed,
    double? percent,
    double? minimum,
    required int ruleId,
    _i2.WithdrawalRule? rule,
  }) : super._(
          id: id,
          fixed: fixed,
          percent: percent,
          minimum: minimum,
          ruleId: ruleId,
          rule: rule,
        );

  @override
  WithdrawalFee copyWith({
    Object? id = _Undefined,
    double? fixed,
    double? percent,
    double? minimum,
    int? ruleId,
    Object? rule = _Undefined,
  }) {
    return WithdrawalFee(
      id: id is int? ? id : this.id,
      fixed: fixed ?? this.fixed,
      percent: percent ?? this.percent,
      minimum: minimum ?? this.minimum,
      ruleId: ruleId ?? this.ruleId,
      rule: rule is _i2.WithdrawalRule? ? rule : this.rule?.copyWith(),
    );
  }
}

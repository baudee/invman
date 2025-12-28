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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i2;
import '../../withdrawal/models/withdrawal_fee.dart' as _i3;
import 'package:invman_client/src/protocol/protocol.dart' as _i4;

abstract class WithdrawalRule implements _i1.SerializableModel {
  WithdrawalRule._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    required this.currencyChangePercentage,
    this.fees,
  });

  factory WithdrawalRule({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required double currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  }) = _WithdrawalRuleImpl;

  factory WithdrawalRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return WithdrawalRule(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      name: jsonSerialization['name'] as String,
      currencyChangePercentage:
          (jsonSerialization['currencyChangePercentage'] as num).toDouble(),
      fees: jsonSerialization['fees'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.WithdrawalFee>>(
              jsonSerialization['fees'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  String name;

  double currencyChangePercentage;

  List<_i3.WithdrawalFee>? fees;

  /// Returns a shallow copy of this [WithdrawalRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WithdrawalRule copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    String? name,
    double? currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WithdrawalRule',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'name': name,
      'currencyChangePercentage': currencyChangePercentage,
      if (fees != null) 'fees': fees?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WithdrawalRuleImpl extends WithdrawalRule {
  _WithdrawalRuleImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required double currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         name: name,
         currencyChangePercentage: currencyChangePercentage,
         fees: fees,
       );

  /// Returns a shallow copy of this [WithdrawalRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WithdrawalRule copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? name,
    double? currencyChangePercentage,
    Object? fees = _Undefined,
  }) {
    return WithdrawalRule(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      currencyChangePercentage:
          currencyChangePercentage ?? this.currencyChangePercentage,
      fees: fees is List<_i3.WithdrawalFee>?
          ? fees
          : this.fees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

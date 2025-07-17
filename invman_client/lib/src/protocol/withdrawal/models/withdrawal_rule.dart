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
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i2;
import '../../withdrawal/models/withdrawal_fee.dart' as _i3;

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
    required int userId,
    _i2.UserInfo? user,
    required String name,
    required double currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  }) = _WithdrawalRuleImpl;

  factory WithdrawalRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return WithdrawalRule(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String,
      currencyChangePercentage:
          (jsonSerialization['currencyChangePercentage'] as num).toDouble(),
      fees: (jsonSerialization['fees'] as List?)
          ?.map((e) => _i3.WithdrawalFee.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserInfo? user;

  String name;

  double currencyChangePercentage;

  List<_i3.WithdrawalFee>? fees;

  WithdrawalRule copyWith({
    int? id,
    int? userId,
    _i2.UserInfo? user,
    String? name,
    double? currencyChangePercentage,
    List<_i3.WithdrawalFee>? fees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
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
    required int userId,
    _i2.UserInfo? user,
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

  @override
  WithdrawalRule copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? name,
    double? currencyChangePercentage,
    Object? fees = _Undefined,
  }) {
    return WithdrawalRule(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserInfo? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      currencyChangePercentage:
          currencyChangePercentage ?? this.currencyChangePercentage,
      fees: fees is List<_i3.WithdrawalFee>?
          ? fees
          : this.fees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

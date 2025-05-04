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

abstract class Withdrawal implements _i1.SerializableModel {
  Withdrawal._({
    this.id,
    required this.userId,
    this.user,
    double? fixed,
    double? percent,
    double? minimum,
  })  : fixed = fixed ?? 0.0,
        percent = percent ?? 0.0,
        minimum = minimum ?? 0.0;

  factory Withdrawal({
    int? id,
    required int userId,
    _i2.UserInfo? user,
    double? fixed,
    double? percent,
    double? minimum,
  }) = _WithdrawalImpl;

  factory Withdrawal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Withdrawal(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      fixed: (jsonSerialization['fixed'] as num).toDouble(),
      percent: (jsonSerialization['percent'] as num).toDouble(),
      minimum: (jsonSerialization['minimum'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserInfo? user;

  double fixed;

  double percent;

  double minimum;

  Withdrawal copyWith({
    int? id,
    int? userId,
    _i2.UserInfo? user,
    double? fixed,
    double? percent,
    double? minimum,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'fixed': fixed,
      'percent': percent,
      'minimum': minimum,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WithdrawalImpl extends Withdrawal {
  _WithdrawalImpl({
    int? id,
    required int userId,
    _i2.UserInfo? user,
    double? fixed,
    double? percent,
    double? minimum,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          fixed: fixed,
          percent: percent,
          minimum: minimum,
        );

  @override
  Withdrawal copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    double? fixed,
    double? percent,
    double? minimum,
  }) {
    return Withdrawal(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserInfo? ? user : this.user?.copyWith(),
      fixed: fixed ?? this.fixed,
      percent: percent ?? this.percent,
      minimum: minimum ?? this.minimum,
    );
  }
}

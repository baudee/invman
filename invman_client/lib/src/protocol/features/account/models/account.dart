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
import '../../../features/account/models/account_plan.dart' as _i2;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i3;
import '../../../features/currency/models/currency.dart' as _i4;
import 'package:invman_client/src/protocol/protocol.dart' as _i5;

abstract class Account implements _i1.SerializableModel {
  Account._({
    this.id,
    required this.userId,
    this.user,
    this.currencyId,
    this.currency,
    _i2.AccountPlan? plan,
  }) : plan = plan ?? _i2.AccountPlan.free;

  factory Account({
    int? id,
    required _i1.UuidValue userId,
    _i3.AuthUser? user,
    int? currencyId,
    _i4.Currency? currency,
    _i2.AccountPlan? plan,
  }) = _AccountImpl;

  factory Account.fromJson(Map<String, dynamic> jsonSerialization) {
    return Account(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AuthUser>(jsonSerialization['user']),
      currencyId: jsonSerialization['currencyId'] as int?,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Currency>(
              jsonSerialization['currency'],
            ),
      plan: jsonSerialization['plan'] == null
          ? null
          : _i2.AccountPlan.fromJson((jsonSerialization['plan'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i3.AuthUser? user;

  int? currencyId;

  _i4.Currency? currency;

  _i2.AccountPlan plan;

  /// Returns a shallow copy of this [Account]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Account copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i3.AuthUser? user,
    int? currencyId,
    _i4.Currency? currency,
    _i2.AccountPlan? plan,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Account',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      if (currencyId != null) 'currencyId': currencyId,
      if (currency != null) 'currency': currency?.toJson(),
      'plan': plan.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountImpl extends Account {
  _AccountImpl({
    int? id,
    required _i1.UuidValue userId,
    _i3.AuthUser? user,
    int? currencyId,
    _i4.Currency? currency,
    _i2.AccountPlan? plan,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         currencyId: currencyId,
         currency: currency,
         plan: plan,
       );

  /// Returns a shallow copy of this [Account]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Account copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    Object? currencyId = _Undefined,
    Object? currency = _Undefined,
    _i2.AccountPlan? plan,
  }) {
    return Account(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i3.AuthUser? ? user : this.user?.copyWith(),
      currencyId: currencyId is int? ? currencyId : this.currencyId,
      currency: currency is _i4.Currency?
          ? currency
          : this.currency?.copyWith(),
      plan: plan ?? this.plan,
    );
  }
}

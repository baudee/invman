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
import '../../../features/account/models/subscription_plan.dart' as _i2;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i3;
import '../../../features/currency/models/currency.dart' as _i4;
import '../../../features/auth/models/user_permissions.dart' as _i5;
import 'package:invman_client/src/protocol/protocol.dart' as _i6;

abstract class Account implements _i1.SerializableModel {
  Account._({
    this.id,
    required this.userId,
    this.user,
    this.currencyId,
    this.currency,
    _i2.SubscriptionPlan? subscriptionPlan,
    this.permissions,
  }) : subscriptionPlan = subscriptionPlan ?? _i2.SubscriptionPlan.free;

  factory Account({
    int? id,
    required _i1.UuidValue userId,
    _i3.AuthUser? user,
    int? currencyId,
    _i4.Currency? currency,
    _i2.SubscriptionPlan? subscriptionPlan,
    _i5.UserPermissions? permissions,
  }) = _AccountImpl;

  factory Account.fromJson(Map<String, dynamic> jsonSerialization) {
    return Account(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.AuthUser>(jsonSerialization['user']),
      currencyId: jsonSerialization['currencyId'] as int?,
      currency: jsonSerialization['currency'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Currency>(
              jsonSerialization['currency'],
            ),
      subscriptionPlan: jsonSerialization['subscriptionPlan'] == null
          ? null
          : _i2.SubscriptionPlan.fromJson(
              (jsonSerialization['subscriptionPlan'] as String),
            ),
      permissions: jsonSerialization['permissions'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.UserPermissions>(
              jsonSerialization['permissions'],
            ),
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

  _i2.SubscriptionPlan subscriptionPlan;

  _i5.UserPermissions? permissions;

  /// Returns a shallow copy of this [Account]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Account copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i3.AuthUser? user,
    int? currencyId,
    _i4.Currency? currency,
    _i2.SubscriptionPlan? subscriptionPlan,
    _i5.UserPermissions? permissions,
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
      'subscriptionPlan': subscriptionPlan.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
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
    _i2.SubscriptionPlan? subscriptionPlan,
    _i5.UserPermissions? permissions,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         currencyId: currencyId,
         currency: currency,
         subscriptionPlan: subscriptionPlan,
         permissions: permissions,
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
    _i2.SubscriptionPlan? subscriptionPlan,
    Object? permissions = _Undefined,
  }) {
    return Account(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i3.AuthUser? ? user : this.user?.copyWith(),
      currencyId: currencyId is int? ? currencyId : this.currencyId,
      currency: currency is _i4.Currency?
          ? currency
          : this.currency?.copyWith(),
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      permissions: permissions is _i5.UserPermissions?
          ? permissions
          : this.permissions?.copyWith(),
    );
  }
}

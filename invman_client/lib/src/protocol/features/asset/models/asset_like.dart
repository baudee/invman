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
import '../../../features/asset/models/asset.dart' as _i3;
import 'package:invman_client/src/protocol/protocol.dart' as _i4;

abstract class AssetLike implements _i1.SerializableModel {
  AssetLike._({
    this.id,
    required this.userId,
    this.user,
    required this.assetId,
    this.asset,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AssetLike({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue assetId,
    _i3.Asset? asset,
    DateTime? createdAt,
  }) = _AssetLikeImpl;

  factory AssetLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssetLike(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      assetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['assetId'],
      ),
      asset: jsonSerialization['asset'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Asset>(jsonSerialization['asset']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  _i1.UuidValue assetId;

  _i3.Asset? asset;

  DateTime createdAt;

  /// Returns a shallow copy of this [AssetLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssetLike copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    _i1.UuidValue? assetId,
    _i3.Asset? asset,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssetLike',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'assetId': assetId.toJson(),
      if (asset != null) 'asset': asset?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetLikeImpl extends AssetLike {
  _AssetLikeImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue assetId,
    _i3.Asset? asset,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         assetId: assetId,
         asset: asset,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AssetLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssetLike copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? assetId,
    Object? asset = _Undefined,
    DateTime? createdAt,
  }) {
    return AssetLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      assetId: assetId ?? this.assetId,
      asset: asset is _i3.Asset? ? asset : this.asset?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

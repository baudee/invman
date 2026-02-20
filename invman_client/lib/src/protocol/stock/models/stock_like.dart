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
import '../../stock/models/stock.dart' as _i3;
import 'package:invman_client/src/protocol/protocol.dart' as _i4;

abstract class StockLike implements _i1.SerializableModel {
  StockLike._({
    this.id,
    required this.userId,
    this.user,
    required this.stockId,
    this.stock,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StockLike({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue stockId,
    _i3.Stock? stock,
    DateTime? createdAt,
  }) = _StockLikeImpl;

  factory StockLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockLike(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      stockId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['stockId'],
      ),
      stock: jsonSerialization['stock'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Stock>(jsonSerialization['stock']),
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

  _i1.UuidValue stockId;

  _i3.Stock? stock;

  DateTime createdAt;

  /// Returns a shallow copy of this [StockLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StockLike copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    _i1.UuidValue? stockId,
    _i3.Stock? stock,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockLike',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockLikeImpl extends StockLike {
  _StockLikeImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required _i1.UuidValue stockId,
    _i3.Stock? stock,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         stockId: stockId,
         stock: stock,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StockLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StockLike copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? stockId,
    Object? stock = _Undefined,
    DateTime? createdAt,
  }) {
    return StockLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      stockId: stockId ?? this.stockId,
      stock: stock is _i3.Stock? ? stock : this.stock?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

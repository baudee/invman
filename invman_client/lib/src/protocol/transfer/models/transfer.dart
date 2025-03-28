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
import '../../stock/models/stock.dart' as _i3;

abstract class Transfer implements _i1.SerializableModel {
  Transfer._({
    this.id,
    required this.userId,
    this.user,
    required this.stockId,
    this.stock,
    required this.quantity,
    required this.amount,
  });

  factory Transfer({
    int? id,
    required int userId,
    _i2.UserInfo? user,
    required int stockId,
    _i3.Stock? stock,
    required double quantity,
    required int amount,
  }) = _TransferImpl;

  factory Transfer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transfer(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      stockId: jsonSerialization['stockId'] as int,
      stock: jsonSerialization['stock'] == null
          ? null
          : _i3.Stock.fromJson(
              (jsonSerialization['stock'] as Map<String, dynamic>)),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      amount: jsonSerialization['amount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserInfo? user;

  int stockId;

  _i3.Stock? stock;

  double quantity;

  int amount;

  Transfer copyWith({
    int? id,
    int? userId,
    _i2.UserInfo? user,
    int? stockId,
    _i3.Stock? stock,
    double? quantity,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'stockId': stockId,
      if (stock != null) 'stock': stock?.toJson(),
      'quantity': quantity,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransferImpl extends Transfer {
  _TransferImpl({
    int? id,
    required int userId,
    _i2.UserInfo? user,
    required int stockId,
    _i3.Stock? stock,
    required double quantity,
    required int amount,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          stockId: stockId,
          stock: stock,
          quantity: quantity,
          amount: amount,
        );

  @override
  Transfer copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? stockId,
    Object? stock = _Undefined,
    double? quantity,
    int? amount,
  }) {
    return Transfer(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserInfo? ? user : this.user?.copyWith(),
      stockId: stockId ?? this.stockId,
      stock: stock is _i3.Stock? ? stock : this.stock?.copyWith(),
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
    );
  }
}

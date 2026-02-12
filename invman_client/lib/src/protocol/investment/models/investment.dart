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
import '../../withdrawal/models/withdrawal_rule.dart' as _i4;
import '../../transfer/models/transfer.dart' as _i5;
import 'package:invman_client/src/protocol/protocol.dart' as _i6;

abstract class Investment implements _i1.SerializableModel {
  Investment._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    required this.stockId,
    this.stock,
    required this.withdrawalRuleId,
    this.withdrawalRule,
    this.transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    this.withdrawAmount,
  }) : investAmount = investAmount ?? 0.0,
       quantity = quantity ?? 0.0,
       updatedAt = updatedAt ?? DateTime.now();

  factory Investment({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required _i1.UuidValue stockId,
    _i3.Stock? stock,
    required int withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    List<_i5.Transfer>? transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    double? withdrawAmount,
  }) = _InvestmentImpl;

  factory Investment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Investment(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.AuthUser>(jsonSerialization['user']),
      name: jsonSerialization['name'] as String,
      stockId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['stockId'],
      ),
      stock: jsonSerialization['stock'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Stock>(jsonSerialization['stock']),
      withdrawalRuleId: jsonSerialization['withdrawalRuleId'] as int,
      withdrawalRule: jsonSerialization['withdrawalRule'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.WithdrawalRule>(
              jsonSerialization['withdrawalRule'],
            ),
      transfers: jsonSerialization['transfers'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.Transfer>>(
              jsonSerialization['transfers'],
            ),
      investAmount: (jsonSerialization['investAmount'] as num?)?.toDouble(),
      quantity: (jsonSerialization['quantity'] as num?)?.toDouble(),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      withdrawAmount: (jsonSerialization['withdrawAmount'] as num?)?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i2.AuthUser? user;

  String name;

  _i1.UuidValue stockId;

  _i3.Stock? stock;

  int withdrawalRuleId;

  _i4.WithdrawalRule? withdrawalRule;

  List<_i5.Transfer>? transfers;

  double investAmount;

  double quantity;

  DateTime updatedAt;

  double? withdrawAmount;

  /// Returns a shallow copy of this [Investment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Investment copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AuthUser? user,
    String? name,
    _i1.UuidValue? stockId,
    _i3.Stock? stock,
    int? withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    List<_i5.Transfer>? transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    double? withdrawAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Investment',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'name': name,
      'stockId': stockId.toJson(),
      if (stock != null) 'stock': stock?.toJson(),
      'withdrawalRuleId': withdrawalRuleId,
      if (withdrawalRule != null) 'withdrawalRule': withdrawalRule?.toJson(),
      if (transfers != null)
        'transfers': transfers?.toJson(valueToJson: (v) => v.toJson()),
      'investAmount': investAmount,
      'quantity': quantity,
      'updatedAt': updatedAt.toJson(),
      if (withdrawAmount != null) 'withdrawAmount': withdrawAmount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvestmentImpl extends Investment {
  _InvestmentImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AuthUser? user,
    required String name,
    required _i1.UuidValue stockId,
    _i3.Stock? stock,
    required int withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    List<_i5.Transfer>? transfers,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    double? withdrawAmount,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         name: name,
         stockId: stockId,
         stock: stock,
         withdrawalRuleId: withdrawalRuleId,
         withdrawalRule: withdrawalRule,
         transfers: transfers,
         investAmount: investAmount,
         quantity: quantity,
         updatedAt: updatedAt,
         withdrawAmount: withdrawAmount,
       );

  /// Returns a shallow copy of this [Investment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Investment copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? name,
    _i1.UuidValue? stockId,
    Object? stock = _Undefined,
    int? withdrawalRuleId,
    Object? withdrawalRule = _Undefined,
    Object? transfers = _Undefined,
    double? investAmount,
    double? quantity,
    DateTime? updatedAt,
    Object? withdrawAmount = _Undefined,
  }) {
    return Investment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AuthUser? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      stockId: stockId ?? this.stockId,
      stock: stock is _i3.Stock? ? stock : this.stock?.copyWith(),
      withdrawalRuleId: withdrawalRuleId ?? this.withdrawalRuleId,
      withdrawalRule: withdrawalRule is _i4.WithdrawalRule?
          ? withdrawalRule
          : this.withdrawalRule?.copyWith(),
      transfers: transfers is List<_i5.Transfer>?
          ? transfers
          : this.transfers?.map((e0) => e0.copyWith()).toList(),
      investAmount: investAmount ?? this.investAmount,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      withdrawAmount: withdrawAmount is double?
          ? withdrawAmount
          : this.withdrawAmount,
    );
  }
}

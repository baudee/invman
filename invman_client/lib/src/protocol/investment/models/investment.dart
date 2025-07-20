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
import '../../transfer/models/transfer.dart' as _i3;
import '../../withdrawal/models/withdrawal_rule.dart' as _i4;
import '../../stock/models/stock.dart' as _i5;

abstract class Investment implements _i1.SerializableModel {
  Investment._({
    this.id,
    required this.userId,
    this.user,
    required this.name,
    this.transfers,
    required this.withdrawalRuleId,
    this.withdrawalRule,
    required this.stockSymbol,
    DateTime? updatedAt,
    this.stock,
    this.investAmount,
    this.withdrawAmount,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory Investment({
    int? id,
    required int userId,
    _i2.UserInfo? user,
    required String name,
    List<_i3.Transfer>? transfers,
    required int withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    required String stockSymbol,
    DateTime? updatedAt,
    _i5.Stock? stock,
    double? investAmount,
    double? withdrawAmount,
  }) = _InvestmentImpl;

  factory Investment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Investment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String,
      transfers: (jsonSerialization['transfers'] as List?)
          ?.map((e) => _i3.Transfer.fromJson((e as Map<String, dynamic>)))
          .toList(),
      withdrawalRuleId: jsonSerialization['withdrawalRuleId'] as int,
      withdrawalRule: jsonSerialization['withdrawalRule'] == null
          ? null
          : _i4.WithdrawalRule.fromJson(
              (jsonSerialization['withdrawalRule'] as Map<String, dynamic>)),
      stockSymbol: jsonSerialization['stockSymbol'] as String,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      stock: jsonSerialization['stock'] == null
          ? null
          : _i5.Stock.fromJson(
              (jsonSerialization['stock'] as Map<String, dynamic>)),
      investAmount: (jsonSerialization['investAmount'] as num?)?.toDouble(),
      withdrawAmount: (jsonSerialization['withdrawAmount'] as num?)?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserInfo? user;

  String name;

  List<_i3.Transfer>? transfers;

  int withdrawalRuleId;

  _i4.WithdrawalRule? withdrawalRule;

  String stockSymbol;

  DateTime updatedAt;

  _i5.Stock? stock;

  double? investAmount;

  double? withdrawAmount;

  Investment copyWith({
    int? id,
    int? userId,
    _i2.UserInfo? user,
    String? name,
    List<_i3.Transfer>? transfers,
    int? withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    String? stockSymbol,
    DateTime? updatedAt,
    _i5.Stock? stock,
    double? investAmount,
    double? withdrawAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'name': name,
      if (transfers != null)
        'transfers': transfers?.toJson(valueToJson: (v) => v.toJson()),
      'withdrawalRuleId': withdrawalRuleId,
      if (withdrawalRule != null) 'withdrawalRule': withdrawalRule?.toJson(),
      'stockSymbol': stockSymbol,
      'updatedAt': updatedAt.toJson(),
      if (stock != null) 'stock': stock?.toJson(),
      if (investAmount != null) 'investAmount': investAmount,
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
    required int userId,
    _i2.UserInfo? user,
    required String name,
    List<_i3.Transfer>? transfers,
    required int withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    required String stockSymbol,
    DateTime? updatedAt,
    _i5.Stock? stock,
    double? investAmount,
    double? withdrawAmount,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          name: name,
          transfers: transfers,
          withdrawalRuleId: withdrawalRuleId,
          withdrawalRule: withdrawalRule,
          stockSymbol: stockSymbol,
          updatedAt: updatedAt,
          stock: stock,
          investAmount: investAmount,
          withdrawAmount: withdrawAmount,
        );

  @override
  Investment copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? name,
    Object? transfers = _Undefined,
    int? withdrawalRuleId,
    Object? withdrawalRule = _Undefined,
    String? stockSymbol,
    DateTime? updatedAt,
    Object? stock = _Undefined,
    Object? investAmount = _Undefined,
    Object? withdrawAmount = _Undefined,
  }) {
    return Investment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserInfo? ? user : this.user?.copyWith(),
      name: name ?? this.name,
      transfers: transfers is List<_i3.Transfer>?
          ? transfers
          : this.transfers?.map((e0) => e0.copyWith()).toList(),
      withdrawalRuleId: withdrawalRuleId ?? this.withdrawalRuleId,
      withdrawalRule: withdrawalRule is _i4.WithdrawalRule?
          ? withdrawalRule
          : this.withdrawalRule?.copyWith(),
      stockSymbol: stockSymbol ?? this.stockSymbol,
      updatedAt: updatedAt ?? this.updatedAt,
      stock: stock is _i5.Stock? ? stock : this.stock?.copyWith(),
      investAmount: investAmount is double? ? investAmount : this.investAmount,
      withdrawAmount:
          withdrawAmount is double? ? withdrawAmount : this.withdrawAmount,
    );
  }
}

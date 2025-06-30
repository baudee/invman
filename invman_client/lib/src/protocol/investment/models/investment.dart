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
    this.transfers,
    required this.withdrawalRuleId,
    this.withdrawalRule,
    required this.stockSymbol,
    required this.stock,
    required this.investAmount,
    required this.withdrawAmount,
  });

  factory Investment({
    int? id,
    required int userId,
    _i2.UserInfo? user,
    List<_i3.Transfer>? transfers,
    required int withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    required String stockSymbol,
    required _i5.Stock stock,
    required int investAmount,
    required int withdrawAmount,
  }) = _InvestmentImpl;

  factory Investment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Investment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      transfers: (jsonSerialization['transfers'] as List?)
          ?.map((e) => _i3.Transfer.fromJson((e as Map<String, dynamic>)))
          .toList(),
      withdrawalRuleId: jsonSerialization['withdrawalRuleId'] as int,
      withdrawalRule: jsonSerialization['withdrawalRule'] == null
          ? null
          : _i4.WithdrawalRule.fromJson(
              (jsonSerialization['withdrawalRule'] as Map<String, dynamic>)),
      stockSymbol: jsonSerialization['stockSymbol'] as String,
      stock: _i5.Stock.fromJson(
          (jsonSerialization['stock'] as Map<String, dynamic>)),
      investAmount: jsonSerialization['investAmount'] as int,
      withdrawAmount: jsonSerialization['withdrawAmount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserInfo? user;

  List<_i3.Transfer>? transfers;

  int withdrawalRuleId;

  _i4.WithdrawalRule? withdrawalRule;

  String stockSymbol;

  _i5.Stock stock;

  int investAmount;

  int withdrawAmount;

  Investment copyWith({
    int? id,
    int? userId,
    _i2.UserInfo? user,
    List<_i3.Transfer>? transfers,
    int? withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    String? stockSymbol,
    _i5.Stock? stock,
    int? investAmount,
    int? withdrawAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (transfers != null)
        'transfers': transfers?.toJson(valueToJson: (v) => v.toJson()),
      'withdrawalRuleId': withdrawalRuleId,
      if (withdrawalRule != null) 'withdrawalRule': withdrawalRule?.toJson(),
      'stockSymbol': stockSymbol,
      'stock': stock.toJson(),
      'investAmount': investAmount,
      'withdrawAmount': withdrawAmount,
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
    List<_i3.Transfer>? transfers,
    required int withdrawalRuleId,
    _i4.WithdrawalRule? withdrawalRule,
    required String stockSymbol,
    required _i5.Stock stock,
    required int investAmount,
    required int withdrawAmount,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          transfers: transfers,
          withdrawalRuleId: withdrawalRuleId,
          withdrawalRule: withdrawalRule,
          stockSymbol: stockSymbol,
          stock: stock,
          investAmount: investAmount,
          withdrawAmount: withdrawAmount,
        );

  @override
  Investment copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    Object? transfers = _Undefined,
    int? withdrawalRuleId,
    Object? withdrawalRule = _Undefined,
    String? stockSymbol,
    _i5.Stock? stock,
    int? investAmount,
    int? withdrawAmount,
  }) {
    return Investment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.UserInfo? ? user : this.user?.copyWith(),
      transfers: transfers is List<_i3.Transfer>?
          ? transfers
          : this.transfers?.map((e0) => e0.copyWith()).toList(),
      withdrawalRuleId: withdrawalRuleId ?? this.withdrawalRuleId,
      withdrawalRule: withdrawalRule is _i4.WithdrawalRule?
          ? withdrawalRule
          : this.withdrawalRule?.copyWith(),
      stockSymbol: stockSymbol ?? this.stockSymbol,
      stock: stock ?? this.stock.copyWith(),
      investAmount: investAmount ?? this.investAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
    );
  }
}

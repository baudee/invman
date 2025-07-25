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
import 'core/exceptions/error_code.dart' as _i2;
import 'core/exceptions/server_exception.dart' as _i3;
import 'investment/models/investment.dart' as _i4;
import 'investment/models/investment_list.dart' as _i5;
import 'stock/models/stock.dart' as _i6;
import 'stock/models/stock_list.dart' as _i7;
import 'transfer/models/transfer.dart' as _i8;
import 'transfer/models/transfer_list.dart' as _i9;
import 'withdrawal/models/withdrawal_fee.dart' as _i10;
import 'withdrawal/models/withdrawal_fee_list.dart' as _i11;
import 'withdrawal/models/withdrawal_rule.dart' as _i12;
import 'withdrawal/models/withdrawal_rule_list.dart' as _i13;
import 'package:invman_client/src/protocol/stock/models/stock.dart' as _i14;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i15;
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'investment/models/investment.dart';
export 'investment/models/investment_list.dart';
export 'stock/models/stock.dart';
export 'stock/models/stock_list.dart';
export 'transfer/models/transfer.dart';
export 'transfer/models/transfer_list.dart';
export 'withdrawal/models/withdrawal_fee.dart';
export 'withdrawal/models/withdrawal_fee_list.dart';
export 'withdrawal/models/withdrawal_rule.dart';
export 'withdrawal/models/withdrawal_rule_list.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.ErrorCode) {
      return _i2.ErrorCode.fromJson(data) as T;
    }
    if (t == _i3.ServerException) {
      return _i3.ServerException.fromJson(data) as T;
    }
    if (t == _i4.Investment) {
      return _i4.Investment.fromJson(data) as T;
    }
    if (t == _i5.InvestmentList) {
      return _i5.InvestmentList.fromJson(data) as T;
    }
    if (t == _i6.Stock) {
      return _i6.Stock.fromJson(data) as T;
    }
    if (t == _i7.StockList) {
      return _i7.StockList.fromJson(data) as T;
    }
    if (t == _i8.Transfer) {
      return _i8.Transfer.fromJson(data) as T;
    }
    if (t == _i9.TransferList) {
      return _i9.TransferList.fromJson(data) as T;
    }
    if (t == _i10.WithdrawalFee) {
      return _i10.WithdrawalFee.fromJson(data) as T;
    }
    if (t == _i11.WithdrawalFeeList) {
      return _i11.WithdrawalFeeList.fromJson(data) as T;
    }
    if (t == _i12.WithdrawalRule) {
      return _i12.WithdrawalRule.fromJson(data) as T;
    }
    if (t == _i13.WithdrawalRuleList) {
      return _i13.WithdrawalRuleList.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ErrorCode?>()) {
      return (data != null ? _i2.ErrorCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ServerException?>()) {
      return (data != null ? _i3.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Investment?>()) {
      return (data != null ? _i4.Investment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.InvestmentList?>()) {
      return (data != null ? _i5.InvestmentList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Stock?>()) {
      return (data != null ? _i6.Stock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.StockList?>()) {
      return (data != null ? _i7.StockList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Transfer?>()) {
      return (data != null ? _i8.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.TransferList?>()) {
      return (data != null ? _i9.TransferList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.WithdrawalFee?>()) {
      return (data != null ? _i10.WithdrawalFee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.WithdrawalFeeList?>()) {
      return (data != null ? _i11.WithdrawalFeeList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.WithdrawalRule?>()) {
      return (data != null ? _i12.WithdrawalRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.WithdrawalRuleList?>()) {
      return (data != null ? _i13.WithdrawalRuleList.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<List<_i8.Transfer>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i8.Transfer>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i4.Investment>) {
      return (data as List).map((e) => deserialize<_i4.Investment>(e)).toList()
          as dynamic;
    }
    if (t == List<_i6.Stock>) {
      return (data as List).map((e) => deserialize<_i6.Stock>(e)).toList()
          as dynamic;
    }
    if (t == List<_i8.Transfer>) {
      return (data as List).map((e) => deserialize<_i8.Transfer>(e)).toList()
          as dynamic;
    }
    if (t == List<_i10.WithdrawalFee>) {
      return (data as List)
          .map((e) => deserialize<_i10.WithdrawalFee>(e))
          .toList() as dynamic;
    }
    if (t == _i1.getType<List<_i10.WithdrawalFee>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.WithdrawalFee>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i12.WithdrawalRule>) {
      return (data as List)
          .map((e) => deserialize<_i12.WithdrawalRule>(e))
          .toList() as dynamic;
    }
    if (t == List<_i14.Stock>) {
      return (data as List).map((e) => deserialize<_i14.Stock>(e)).toList()
          as dynamic;
    }
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.ErrorCode) {
      return 'ErrorCode';
    }
    if (data is _i3.ServerException) {
      return 'ServerException';
    }
    if (data is _i4.Investment) {
      return 'Investment';
    }
    if (data is _i5.InvestmentList) {
      return 'InvestmentList';
    }
    if (data is _i6.Stock) {
      return 'Stock';
    }
    if (data is _i7.StockList) {
      return 'StockList';
    }
    if (data is _i8.Transfer) {
      return 'Transfer';
    }
    if (data is _i9.TransferList) {
      return 'TransferList';
    }
    if (data is _i10.WithdrawalFee) {
      return 'WithdrawalFee';
    }
    if (data is _i11.WithdrawalFeeList) {
      return 'WithdrawalFeeList';
    }
    if (data is _i12.WithdrawalRule) {
      return 'WithdrawalRule';
    }
    if (data is _i13.WithdrawalRuleList) {
      return 'WithdrawalRuleList';
    }
    className = _i15.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ErrorCode') {
      return deserialize<_i2.ErrorCode>(data['data']);
    }
    if (dataClassName == 'ServerException') {
      return deserialize<_i3.ServerException>(data['data']);
    }
    if (dataClassName == 'Investment') {
      return deserialize<_i4.Investment>(data['data']);
    }
    if (dataClassName == 'InvestmentList') {
      return deserialize<_i5.InvestmentList>(data['data']);
    }
    if (dataClassName == 'Stock') {
      return deserialize<_i6.Stock>(data['data']);
    }
    if (dataClassName == 'StockList') {
      return deserialize<_i7.StockList>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i8.Transfer>(data['data']);
    }
    if (dataClassName == 'TransferList') {
      return deserialize<_i9.TransferList>(data['data']);
    }
    if (dataClassName == 'WithdrawalFee') {
      return deserialize<_i10.WithdrawalFee>(data['data']);
    }
    if (dataClassName == 'WithdrawalFeeList') {
      return deserialize<_i11.WithdrawalFeeList>(data['data']);
    }
    if (dataClassName == 'WithdrawalRule') {
      return deserialize<_i12.WithdrawalRule>(data['data']);
    }
    if (dataClassName == 'WithdrawalRuleList') {
      return deserialize<_i13.WithdrawalRuleList>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i15.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}

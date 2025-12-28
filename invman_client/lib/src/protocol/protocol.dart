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
import 'core/exceptions/error_code.dart' as _i2;
import 'core/exceptions/server_exception.dart' as _i3;
import 'investment/models/investment.dart' as _i4;
import 'stock/models/cached_currency_change.dart' as _i5;
import 'stock/models/cached_stock_search.dart' as _i6;
import 'stock/models/stock.dart' as _i7;
import 'stock/models/stock_list.dart' as _i8;
import 'transfer/models/transfer.dart' as _i9;
import 'transfer/models/transfer_list.dart' as _i10;
import 'withdrawal/models/withdrawal_fee.dart' as _i11;
import 'withdrawal/models/withdrawal_fee_list.dart' as _i12;
import 'withdrawal/models/withdrawal_rule.dart' as _i13;
import 'withdrawal/models/withdrawal_rule_list.dart' as _i14;
import 'package:invman_client/src/protocol/investment/models/investment.dart'
    as _i15;
import 'package:invman_client/src/protocol/stock/models/stock.dart' as _i16;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i17;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i18;
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'investment/models/investment.dart';
export 'stock/models/cached_currency_change.dart';
export 'stock/models/cached_stock_search.dart';
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

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.ErrorCode) {
      return _i2.ErrorCode.fromJson(data) as T;
    }
    if (t == _i3.ServerException) {
      return _i3.ServerException.fromJson(data) as T;
    }
    if (t == _i4.Investment) {
      return _i4.Investment.fromJson(data) as T;
    }
    if (t == _i5.CachedCurrencyChange) {
      return _i5.CachedCurrencyChange.fromJson(data) as T;
    }
    if (t == _i6.CachedStockSearch) {
      return _i6.CachedStockSearch.fromJson(data) as T;
    }
    if (t == _i7.Stock) {
      return _i7.Stock.fromJson(data) as T;
    }
    if (t == _i8.StockList) {
      return _i8.StockList.fromJson(data) as T;
    }
    if (t == _i9.Transfer) {
      return _i9.Transfer.fromJson(data) as T;
    }
    if (t == _i10.TransferList) {
      return _i10.TransferList.fromJson(data) as T;
    }
    if (t == _i11.WithdrawalFee) {
      return _i11.WithdrawalFee.fromJson(data) as T;
    }
    if (t == _i12.WithdrawalFeeList) {
      return _i12.WithdrawalFeeList.fromJson(data) as T;
    }
    if (t == _i13.WithdrawalRule) {
      return _i13.WithdrawalRule.fromJson(data) as T;
    }
    if (t == _i14.WithdrawalRuleList) {
      return _i14.WithdrawalRuleList.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.CachedCurrencyChange?>()) {
      return (data != null ? _i5.CachedCurrencyChange.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.CachedStockSearch?>()) {
      return (data != null ? _i6.CachedStockSearch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Stock?>()) {
      return (data != null ? _i7.Stock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.StockList?>()) {
      return (data != null ? _i8.StockList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Transfer?>()) {
      return (data != null ? _i9.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.TransferList?>()) {
      return (data != null ? _i10.TransferList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.WithdrawalFee?>()) {
      return (data != null ? _i11.WithdrawalFee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.WithdrawalFeeList?>()) {
      return (data != null ? _i12.WithdrawalFeeList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.WithdrawalRule?>()) {
      return (data != null ? _i13.WithdrawalRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.WithdrawalRuleList?>()) {
      return (data != null ? _i14.WithdrawalRuleList.fromJson(data) : null)
          as T;
    }
    if (t == List<_i9.Transfer>) {
      return (data as List).map((e) => deserialize<_i9.Transfer>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i9.Transfer>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i9.Transfer>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i7.Stock>) {
      return (data as List).map((e) => deserialize<_i7.Stock>(e)).toList() as T;
    }
    if (t == List<_i11.WithdrawalFee>) {
      return (data as List)
              .map((e) => deserialize<_i11.WithdrawalFee>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.WithdrawalFee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.WithdrawalFee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i13.WithdrawalRule>) {
      return (data as List)
              .map((e) => deserialize<_i13.WithdrawalRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.Investment>) {
      return (data as List).map((e) => deserialize<_i15.Investment>(e)).toList()
          as T;
    }
    if (t == List<_i16.Stock>) {
      return (data as List).map((e) => deserialize<_i16.Stock>(e)).toList()
          as T;
    }
    try {
      return _i17.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i18.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.ErrorCode => 'ErrorCode',
      _i3.ServerException => 'ServerException',
      _i4.Investment => 'Investment',
      _i5.CachedCurrencyChange => 'CachedCurrencyChange',
      _i6.CachedStockSearch => 'CachedStockSearch',
      _i7.Stock => 'Stock',
      _i8.StockList => 'StockList',
      _i9.Transfer => 'Transfer',
      _i10.TransferList => 'TransferList',
      _i11.WithdrawalFee => 'WithdrawalFee',
      _i12.WithdrawalFeeList => 'WithdrawalFeeList',
      _i13.WithdrawalRule => 'WithdrawalRule',
      _i14.WithdrawalRuleList => 'WithdrawalRuleList',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('invman.', '');
    }

    switch (data) {
      case _i2.ErrorCode():
        return 'ErrorCode';
      case _i3.ServerException():
        return 'ServerException';
      case _i4.Investment():
        return 'Investment';
      case _i5.CachedCurrencyChange():
        return 'CachedCurrencyChange';
      case _i6.CachedStockSearch():
        return 'CachedStockSearch';
      case _i7.Stock():
        return 'Stock';
      case _i8.StockList():
        return 'StockList';
      case _i9.Transfer():
        return 'Transfer';
      case _i10.TransferList():
        return 'TransferList';
      case _i11.WithdrawalFee():
        return 'WithdrawalFee';
      case _i12.WithdrawalFeeList():
        return 'WithdrawalFeeList';
      case _i13.WithdrawalRule():
        return 'WithdrawalRule';
      case _i14.WithdrawalRuleList():
        return 'WithdrawalRuleList';
    }
    className = _i17.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i18.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
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
    if (dataClassName == 'CachedCurrencyChange') {
      return deserialize<_i5.CachedCurrencyChange>(data['data']);
    }
    if (dataClassName == 'CachedStockSearch') {
      return deserialize<_i6.CachedStockSearch>(data['data']);
    }
    if (dataClassName == 'Stock') {
      return deserialize<_i7.Stock>(data['data']);
    }
    if (dataClassName == 'StockList') {
      return deserialize<_i8.StockList>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i9.Transfer>(data['data']);
    }
    if (dataClassName == 'TransferList') {
      return deserialize<_i10.TransferList>(data['data']);
    }
    if (dataClassName == 'WithdrawalFee') {
      return deserialize<_i11.WithdrawalFee>(data['data']);
    }
    if (dataClassName == 'WithdrawalFeeList') {
      return deserialize<_i12.WithdrawalFeeList>(data['data']);
    }
    if (dataClassName == 'WithdrawalRule') {
      return deserialize<_i13.WithdrawalRule>(data['data']);
    }
    if (dataClassName == 'WithdrawalRuleList') {
      return deserialize<_i14.WithdrawalRuleList>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i17.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i18.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}

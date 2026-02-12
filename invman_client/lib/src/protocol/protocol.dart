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
import 'account/models/account.dart' as _i2;
import 'core/exceptions/error_code.dart' as _i3;
import 'core/exceptions/server_exception.dart' as _i4;
import 'stock/models/stock_list.dart' as _i5;
import 'core/models/pagination_list.dart' as _i6;
import 'currency/models/currency.dart' as _i7;
import 'currency/models/currency_rate.dart' as _i8;
import 'investment/models/investment.dart' as _i9;
import 'stock/models/stock.dart' as _i10;
import 'stock/models/stock_price.dart' as _i11;
import 'stock/models/stock_type.dart' as _i12;
import 'transfer/models/transfer.dart' as _i13;
import 'transfer/models/transfer_list.dart' as _i14;
import 'withdrawal/models/withdrawal_fee.dart' as _i15;
import 'withdrawal/models/withdrawal_fee_list.dart' as _i16;
import 'withdrawal/models/withdrawal_rule.dart' as _i17;
import 'withdrawal/models/withdrawal_rule_list.dart' as _i18;
import 'package:invman_client/src/protocol/currency/models/currency.dart'
    as _i19;
import 'package:invman_client/src/protocol/investment/models/investment.dart'
    as _i20;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i21;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i22;
export 'account/models/account.dart';
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'stock/models/stock_list.dart';
export 'core/models/pagination_list.dart';
export 'currency/models/currency.dart';
export 'currency/models/currency_rate.dart';
export 'investment/models/investment.dart';
export 'stock/models/stock.dart';
export 'stock/models/stock_price.dart';
export 'stock/models/stock_type.dart';
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

    if (t == _i2.Account) {
      return _i2.Account.fromJson(data) as T;
    }
    if (t == _i3.ErrorCode) {
      return _i3.ErrorCode.fromJson(data) as T;
    }
    if (t == _i4.ServerException) {
      return _i4.ServerException.fromJson(data) as T;
    }
    if (t == _i5.StockList) {
      return _i5.StockList.fromJson(data) as T;
    }
    if (t == _i6.PaginationList) {
      return _i6.PaginationList.fromJson(data) as T;
    }
    if (t == _i7.Currency) {
      return _i7.Currency.fromJson(data) as T;
    }
    if (t == _i8.CurrencyRate) {
      return _i8.CurrencyRate.fromJson(data) as T;
    }
    if (t == _i9.Investment) {
      return _i9.Investment.fromJson(data) as T;
    }
    if (t == _i10.Stock) {
      return _i10.Stock.fromJson(data) as T;
    }
    if (t == _i11.StockPrice) {
      return _i11.StockPrice.fromJson(data) as T;
    }
    if (t == _i12.StockType) {
      return _i12.StockType.fromJson(data) as T;
    }
    if (t == _i13.Transfer) {
      return _i13.Transfer.fromJson(data) as T;
    }
    if (t == _i14.TransferList) {
      return _i14.TransferList.fromJson(data) as T;
    }
    if (t == _i15.WithdrawalFee) {
      return _i15.WithdrawalFee.fromJson(data) as T;
    }
    if (t == _i16.WithdrawalFeeList) {
      return _i16.WithdrawalFeeList.fromJson(data) as T;
    }
    if (t == _i17.WithdrawalRule) {
      return _i17.WithdrawalRule.fromJson(data) as T;
    }
    if (t == _i18.WithdrawalRuleList) {
      return _i18.WithdrawalRuleList.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Account?>()) {
      return (data != null ? _i2.Account.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ErrorCode?>()) {
      return (data != null ? _i3.ErrorCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ServerException?>()) {
      return (data != null ? _i4.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.StockList?>()) {
      return (data != null ? _i5.StockList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.PaginationList?>()) {
      return (data != null ? _i6.PaginationList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Currency?>()) {
      return (data != null ? _i7.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CurrencyRate?>()) {
      return (data != null ? _i8.CurrencyRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Investment?>()) {
      return (data != null ? _i9.Investment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Stock?>()) {
      return (data != null ? _i10.Stock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.StockPrice?>()) {
      return (data != null ? _i11.StockPrice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.StockType?>()) {
      return (data != null ? _i12.StockType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Transfer?>()) {
      return (data != null ? _i13.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.TransferList?>()) {
      return (data != null ? _i14.TransferList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.WithdrawalFee?>()) {
      return (data != null ? _i15.WithdrawalFee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.WithdrawalFeeList?>()) {
      return (data != null ? _i16.WithdrawalFeeList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.WithdrawalRule?>()) {
      return (data != null ? _i17.WithdrawalRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.WithdrawalRuleList?>()) {
      return (data != null ? _i18.WithdrawalRuleList.fromJson(data) : null)
          as T;
    }
    if (t == List<_i10.Stock>) {
      return (data as List).map((e) => deserialize<_i10.Stock>(e)).toList()
          as T;
    }
    if (t == List<_i8.CurrencyRate>) {
      return (data as List)
              .map((e) => deserialize<_i8.CurrencyRate>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i8.CurrencyRate>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i8.CurrencyRate>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i13.Transfer>) {
      return (data as List).map((e) => deserialize<_i13.Transfer>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i13.Transfer>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i13.Transfer>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i11.StockPrice>) {
      return (data as List).map((e) => deserialize<_i11.StockPrice>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.StockPrice>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.StockPrice>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i15.WithdrawalFee>) {
      return (data as List)
              .map((e) => deserialize<_i15.WithdrawalFee>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i15.WithdrawalFee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i15.WithdrawalFee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i17.WithdrawalRule>) {
      return (data as List)
              .map((e) => deserialize<_i17.WithdrawalRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.Currency>) {
      return (data as List).map((e) => deserialize<_i19.Currency>(e)).toList()
          as T;
    }
    if (t == List<_i20.Investment>) {
      return (data as List).map((e) => deserialize<_i20.Investment>(e)).toList()
          as T;
    }
    try {
      return _i21.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i22.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Account => 'Account',
      _i3.ErrorCode => 'ErrorCode',
      _i4.ServerException => 'ServerException',
      _i5.StockList => 'StockList',
      _i6.PaginationList => 'PaginationList',
      _i7.Currency => 'Currency',
      _i8.CurrencyRate => 'CurrencyRate',
      _i9.Investment => 'Investment',
      _i10.Stock => 'Stock',
      _i11.StockPrice => 'StockPrice',
      _i12.StockType => 'StockType',
      _i13.Transfer => 'Transfer',
      _i14.TransferList => 'TransferList',
      _i15.WithdrawalFee => 'WithdrawalFee',
      _i16.WithdrawalFeeList => 'WithdrawalFeeList',
      _i17.WithdrawalRule => 'WithdrawalRule',
      _i18.WithdrawalRuleList => 'WithdrawalRuleList',
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
      case _i2.Account():
        return 'Account';
      case _i3.ErrorCode():
        return 'ErrorCode';
      case _i4.ServerException():
        return 'ServerException';
      case _i5.StockList():
        return 'StockList';
      case _i6.PaginationList():
        return 'PaginationList';
      case _i7.Currency():
        return 'Currency';
      case _i8.CurrencyRate():
        return 'CurrencyRate';
      case _i9.Investment():
        return 'Investment';
      case _i10.Stock():
        return 'Stock';
      case _i11.StockPrice():
        return 'StockPrice';
      case _i12.StockType():
        return 'StockType';
      case _i13.Transfer():
        return 'Transfer';
      case _i14.TransferList():
        return 'TransferList';
      case _i15.WithdrawalFee():
        return 'WithdrawalFee';
      case _i16.WithdrawalFeeList():
        return 'WithdrawalFeeList';
      case _i17.WithdrawalRule():
        return 'WithdrawalRule';
      case _i18.WithdrawalRuleList():
        return 'WithdrawalRuleList';
    }
    className = _i21.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i22.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Account') {
      return deserialize<_i2.Account>(data['data']);
    }
    if (dataClassName == 'ErrorCode') {
      return deserialize<_i3.ErrorCode>(data['data']);
    }
    if (dataClassName == 'ServerException') {
      return deserialize<_i4.ServerException>(data['data']);
    }
    if (dataClassName == 'StockList') {
      return deserialize<_i5.StockList>(data['data']);
    }
    if (dataClassName == 'PaginationList') {
      return deserialize<_i6.PaginationList>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i7.Currency>(data['data']);
    }
    if (dataClassName == 'CurrencyRate') {
      return deserialize<_i8.CurrencyRate>(data['data']);
    }
    if (dataClassName == 'Investment') {
      return deserialize<_i9.Investment>(data['data']);
    }
    if (dataClassName == 'Stock') {
      return deserialize<_i10.Stock>(data['data']);
    }
    if (dataClassName == 'StockPrice') {
      return deserialize<_i11.StockPrice>(data['data']);
    }
    if (dataClassName == 'StockType') {
      return deserialize<_i12.StockType>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i13.Transfer>(data['data']);
    }
    if (dataClassName == 'TransferList') {
      return deserialize<_i14.TransferList>(data['data']);
    }
    if (dataClassName == 'WithdrawalFee') {
      return deserialize<_i15.WithdrawalFee>(data['data']);
    }
    if (dataClassName == 'WithdrawalFeeList') {
      return deserialize<_i16.WithdrawalFeeList>(data['data']);
    }
    if (dataClassName == 'WithdrawalRule') {
      return deserialize<_i17.WithdrawalRule>(data['data']);
    }
    if (dataClassName == 'WithdrawalRuleList') {
      return deserialize<_i18.WithdrawalRuleList>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i21.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i22.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i21.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i22.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}

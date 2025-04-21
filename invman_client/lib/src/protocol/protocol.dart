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
import 'package:invman_client/src/protocol/stock/models/stock.dart' as _i10;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i11;
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'investment/models/investment.dart';
export 'investment/models/investment_list.dart';
export 'stock/models/stock.dart';
export 'stock/models/stock_list.dart';
export 'transfer/models/transfer.dart';
export 'transfer/models/transfer_list.dart';
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
    if (t == List<_i4.Investment>) {
      return (data as List).map((e) => deserialize<_i4.Investment>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<_i8.Transfer>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i8.Transfer>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i6.Stock>) {
      return (data as List).map((e) => deserialize<_i6.Stock>(e)).toList()
          as dynamic;
    }
    if (t == List<_i8.Transfer>) {
      return (data as List).map((e) => deserialize<_i8.Transfer>(e)).toList()
          as dynamic;
    }
    if (t == List<_i10.Stock>) {
      return (data as List).map((e) => deserialize<_i10.Stock>(e)).toList()
          as dynamic;
    }
    try {
      return _i11.Protocol().deserialize<T>(data, t);
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
    className = _i11.Protocol().getClassNameForObject(data);
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
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i11.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}

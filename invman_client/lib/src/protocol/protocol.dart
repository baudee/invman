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
import 'stock/data/models/fmp_stock_info.dart' as _i4;
import 'stock/models/stock.dart' as _i5;
import 'stock/models/stock_list.dart' as _i6;
import 'transfer/models/transfer.dart' as _i7;
import 'transfer/models/transfer_list.dart' as _i8;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i9;
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'stock/data/models/fmp_stock_info.dart';
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
    if (t == _i4.FmpStockInfo) {
      return _i4.FmpStockInfo.fromJson(data) as T;
    }
    if (t == _i5.Stock) {
      return _i5.Stock.fromJson(data) as T;
    }
    if (t == _i6.StockList) {
      return _i6.StockList.fromJson(data) as T;
    }
    if (t == _i7.Transfer) {
      return _i7.Transfer.fromJson(data) as T;
    }
    if (t == _i8.TransferList) {
      return _i8.TransferList.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ErrorCode?>()) {
      return (data != null ? _i2.ErrorCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ServerException?>()) {
      return (data != null ? _i3.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.FmpStockInfo?>()) {
      return (data != null ? _i4.FmpStockInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Stock?>()) {
      return (data != null ? _i5.Stock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.StockList?>()) {
      return (data != null ? _i6.StockList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Transfer?>()) {
      return (data != null ? _i7.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.TransferList?>()) {
      return (data != null ? _i8.TransferList.fromJson(data) : null) as T;
    }
    if (t == List<_i5.Stock>) {
      return (data as List).map((e) => deserialize<_i5.Stock>(e)).toList()
          as dynamic;
    }
    if (t == List<_i7.Transfer>) {
      return (data as List).map((e) => deserialize<_i7.Transfer>(e)).toList()
          as dynamic;
    }
    try {
      return _i9.Protocol().deserialize<T>(data, t);
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
    if (data is _i4.FmpStockInfo) {
      return 'FmpStockInfo';
    }
    if (data is _i5.Stock) {
      return 'Stock';
    }
    if (data is _i6.StockList) {
      return 'StockList';
    }
    if (data is _i7.Transfer) {
      return 'Transfer';
    }
    if (data is _i8.TransferList) {
      return 'TransferList';
    }
    className = _i9.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'FmpStockInfo') {
      return deserialize<_i4.FmpStockInfo>(data['data']);
    }
    if (dataClassName == 'Stock') {
      return deserialize<_i5.Stock>(data['data']);
    }
    if (dataClassName == 'StockList') {
      return deserialize<_i6.StockList>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i7.Transfer>(data['data']);
    }
    if (dataClassName == 'TransferList') {
      return deserialize<_i8.TransferList>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i9.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}

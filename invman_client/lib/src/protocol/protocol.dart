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
import 'features/account/models/account.dart' as _i4;
import 'features/app_settings/models/app_settings.dart' as _i5;
import 'features/asset/models/asset.dart' as _i6;
import 'features/asset/models/asset_filter.dart' as _i7;
import 'features/asset/models/asset_like.dart' as _i8;
import 'features/asset/models/asset_time_horizon.dart' as _i9;
import 'features/asset/models/asset_type.dart' as _i10;
import 'features/asset/models/asset_value.dart' as _i11;
import 'features/currency/models/currency.dart' as _i12;
import 'features/currency/models/forex.dart' as _i13;
import 'features/investment/models/investment.dart' as _i14;
import 'features/investment/models/return.dart' as _i15;
import 'features/investment/models/return_interval.dart' as _i16;
import 'features/transfer/models/transfer.dart' as _i17;
import 'features/withdrawal/models/withdrawal_fee.dart' as _i18;
import 'features/withdrawal/models/withdrawal_rule.dart' as _i19;
import 'package:invman_client/src/protocol/features/asset/models/asset.dart'
    as _i20;
import 'package:invman_client/src/protocol/features/asset/models/asset_value.dart'
    as _i21;
import 'package:invman_client/src/protocol/features/currency/models/currency.dart'
    as _i22;
import 'package:invman_client/src/protocol/features/investment/models/investment.dart'
    as _i23;
import 'package:invman_client/src/protocol/features/investment/models/return.dart'
    as _i24;
import 'package:invman_client/src/protocol/features/transfer/models/transfer.dart'
    as _i25;
import 'package:invman_client/src/protocol/features/withdrawal/models/withdrawal_rule.dart'
    as _i26;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i27;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i28;
export 'core/exceptions/error_code.dart';
export 'core/exceptions/server_exception.dart';
export 'features/account/models/account.dart';
export 'features/app_settings/models/app_settings.dart';
export 'features/asset/models/asset.dart';
export 'features/asset/models/asset_filter.dart';
export 'features/asset/models/asset_like.dart';
export 'features/asset/models/asset_time_horizon.dart';
export 'features/asset/models/asset_type.dart';
export 'features/asset/models/asset_value.dart';
export 'features/currency/models/currency.dart';
export 'features/currency/models/forex.dart';
export 'features/investment/models/investment.dart';
export 'features/investment/models/return.dart';
export 'features/investment/models/return_interval.dart';
export 'features/transfer/models/transfer.dart';
export 'features/withdrawal/models/withdrawal_fee.dart';
export 'features/withdrawal/models/withdrawal_rule.dart';
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
    if (t == _i4.Account) {
      return _i4.Account.fromJson(data) as T;
    }
    if (t == _i5.AppSettings) {
      return _i5.AppSettings.fromJson(data) as T;
    }
    if (t == _i6.Asset) {
      return _i6.Asset.fromJson(data) as T;
    }
    if (t == _i7.AssetFilter) {
      return _i7.AssetFilter.fromJson(data) as T;
    }
    if (t == _i8.AssetLike) {
      return _i8.AssetLike.fromJson(data) as T;
    }
    if (t == _i9.AssetTimeHorizon) {
      return _i9.AssetTimeHorizon.fromJson(data) as T;
    }
    if (t == _i10.AssetType) {
      return _i10.AssetType.fromJson(data) as T;
    }
    if (t == _i11.AssetValue) {
      return _i11.AssetValue.fromJson(data) as T;
    }
    if (t == _i12.Currency) {
      return _i12.Currency.fromJson(data) as T;
    }
    if (t == _i13.Forex) {
      return _i13.Forex.fromJson(data) as T;
    }
    if (t == _i14.Investment) {
      return _i14.Investment.fromJson(data) as T;
    }
    if (t == _i15.InvestmentReturn) {
      return _i15.InvestmentReturn.fromJson(data) as T;
    }
    if (t == _i16.InvestmentReturnInterval) {
      return _i16.InvestmentReturnInterval.fromJson(data) as T;
    }
    if (t == _i17.Transfer) {
      return _i17.Transfer.fromJson(data) as T;
    }
    if (t == _i18.WithdrawalFee) {
      return _i18.WithdrawalFee.fromJson(data) as T;
    }
    if (t == _i19.WithdrawalRule) {
      return _i19.WithdrawalRule.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ErrorCode?>()) {
      return (data != null ? _i2.ErrorCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ServerException?>()) {
      return (data != null ? _i3.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Account?>()) {
      return (data != null ? _i4.Account.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AppSettings?>()) {
      return (data != null ? _i5.AppSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Asset?>()) {
      return (data != null ? _i6.Asset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AssetFilter?>()) {
      return (data != null ? _i7.AssetFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AssetLike?>()) {
      return (data != null ? _i8.AssetLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AssetTimeHorizon?>()) {
      return (data != null ? _i9.AssetTimeHorizon.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AssetType?>()) {
      return (data != null ? _i10.AssetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AssetValue?>()) {
      return (data != null ? _i11.AssetValue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Currency?>()) {
      return (data != null ? _i12.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Forex?>()) {
      return (data != null ? _i13.Forex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Investment?>()) {
      return (data != null ? _i14.Investment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.InvestmentReturn?>()) {
      return (data != null ? _i15.InvestmentReturn.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.InvestmentReturnInterval?>()) {
      return (data != null
              ? _i16.InvestmentReturnInterval.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i17.Transfer?>()) {
      return (data != null ? _i17.Transfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.WithdrawalFee?>()) {
      return (data != null ? _i18.WithdrawalFee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.WithdrawalRule?>()) {
      return (data != null ? _i19.WithdrawalRule.fromJson(data) : null) as T;
    }
    if (t == List<_i8.AssetLike>) {
      return (data as List).map((e) => deserialize<_i8.AssetLike>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i8.AssetLike>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i8.AssetLike>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i14.Investment>) {
      return (data as List).map((e) => deserialize<_i14.Investment>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i14.Investment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i14.Investment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i17.Transfer>) {
      return (data as List).map((e) => deserialize<_i17.Transfer>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i17.Transfer>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i17.Transfer>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i18.WithdrawalFee>) {
      return (data as List)
              .map((e) => deserialize<_i18.WithdrawalFee>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.WithdrawalFee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.WithdrawalFee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i20.Asset>) {
      return (data as List).map((e) => deserialize<_i20.Asset>(e)).toList()
          as T;
    }
    if (t == List<_i21.AssetValue>) {
      return (data as List).map((e) => deserialize<_i21.AssetValue>(e)).toList()
          as T;
    }
    if (t == List<_i22.Currency>) {
      return (data as List).map((e) => deserialize<_i22.Currency>(e)).toList()
          as T;
    }
    if (t == List<_i23.Investment>) {
      return (data as List).map((e) => deserialize<_i23.Investment>(e)).toList()
          as T;
    }
    if (t == List<_i24.InvestmentReturn>) {
      return (data as List)
              .map((e) => deserialize<_i24.InvestmentReturn>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.Transfer>) {
      return (data as List).map((e) => deserialize<_i25.Transfer>(e)).toList()
          as T;
    }
    if (t == List<_i26.WithdrawalRule>) {
      return (data as List)
              .map((e) => deserialize<_i26.WithdrawalRule>(e))
              .toList()
          as T;
    }
    try {
      return _i27.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i28.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.ErrorCode => 'ErrorCode',
      _i3.ServerException => 'ServerException',
      _i4.Account => 'Account',
      _i5.AppSettings => 'AppSettings',
      _i6.Asset => 'Asset',
      _i7.AssetFilter => 'AssetFilter',
      _i8.AssetLike => 'AssetLike',
      _i9.AssetTimeHorizon => 'AssetTimeHorizon',
      _i10.AssetType => 'AssetType',
      _i11.AssetValue => 'AssetValue',
      _i12.Currency => 'Currency',
      _i13.Forex => 'Forex',
      _i14.Investment => 'Investment',
      _i15.InvestmentReturn => 'InvestmentReturn',
      _i16.InvestmentReturnInterval => 'InvestmentReturnInterval',
      _i17.Transfer => 'Transfer',
      _i18.WithdrawalFee => 'WithdrawalFee',
      _i19.WithdrawalRule => 'WithdrawalRule',
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
      case _i4.Account():
        return 'Account';
      case _i5.AppSettings():
        return 'AppSettings';
      case _i6.Asset():
        return 'Asset';
      case _i7.AssetFilter():
        return 'AssetFilter';
      case _i8.AssetLike():
        return 'AssetLike';
      case _i9.AssetTimeHorizon():
        return 'AssetTimeHorizon';
      case _i10.AssetType():
        return 'AssetType';
      case _i11.AssetValue():
        return 'AssetValue';
      case _i12.Currency():
        return 'Currency';
      case _i13.Forex():
        return 'Forex';
      case _i14.Investment():
        return 'Investment';
      case _i15.InvestmentReturn():
        return 'InvestmentReturn';
      case _i16.InvestmentReturnInterval():
        return 'InvestmentReturnInterval';
      case _i17.Transfer():
        return 'Transfer';
      case _i18.WithdrawalFee():
        return 'WithdrawalFee';
      case _i19.WithdrawalRule():
        return 'WithdrawalRule';
    }
    className = _i27.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i28.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Account') {
      return deserialize<_i4.Account>(data['data']);
    }
    if (dataClassName == 'AppSettings') {
      return deserialize<_i5.AppSettings>(data['data']);
    }
    if (dataClassName == 'Asset') {
      return deserialize<_i6.Asset>(data['data']);
    }
    if (dataClassName == 'AssetFilter') {
      return deserialize<_i7.AssetFilter>(data['data']);
    }
    if (dataClassName == 'AssetLike') {
      return deserialize<_i8.AssetLike>(data['data']);
    }
    if (dataClassName == 'AssetTimeHorizon') {
      return deserialize<_i9.AssetTimeHorizon>(data['data']);
    }
    if (dataClassName == 'AssetType') {
      return deserialize<_i10.AssetType>(data['data']);
    }
    if (dataClassName == 'AssetValue') {
      return deserialize<_i11.AssetValue>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i12.Currency>(data['data']);
    }
    if (dataClassName == 'Forex') {
      return deserialize<_i13.Forex>(data['data']);
    }
    if (dataClassName == 'Investment') {
      return deserialize<_i14.Investment>(data['data']);
    }
    if (dataClassName == 'InvestmentReturn') {
      return deserialize<_i15.InvestmentReturn>(data['data']);
    }
    if (dataClassName == 'InvestmentReturnInterval') {
      return deserialize<_i16.InvestmentReturnInterval>(data['data']);
    }
    if (dataClassName == 'Transfer') {
      return deserialize<_i17.Transfer>(data['data']);
    }
    if (dataClassName == 'WithdrawalFee') {
      return deserialize<_i18.WithdrawalFee>(data['data']);
    }
    if (dataClassName == 'WithdrawalRule') {
      return deserialize<_i19.WithdrawalRule>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i27.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i28.Protocol().deserializeByClassName(data);
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
      return _i27.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i28.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}

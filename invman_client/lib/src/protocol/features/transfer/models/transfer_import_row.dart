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
import '../../../features/transfer/models/transfer_import_row_status.dart'
    as _i2;
import '../../../features/transfer/models/transfer_import_row_resolution.dart'
    as _i3;
import '../../../features/asset/models/asset.dart' as _i4;
import '../../../features/transfer/models/transfer_import_row_error.dart'
    as _i5;
import 'package:invman_client/src/protocol/protocol.dart' as _i6;

abstract class TransferImportRow implements _i1.SerializableModel {
  TransferImportRow._({
    required this.lineNumber,
    required this.groupId,
    required this.status,
    required this.resolution,
    this.existingInvestmentId,
    this.existingInvestmentName,
    this.newInvestmentName,
    this.newInvestmentWithdrawalRuleId,
    this.asset,
    this.assetCandidates,
    this.quantity,
    this.amount,
    this.date,
    this.investmentErrorKey,
    this.investmentErrorContext,
    this.rowErrorKey,
    this.rowErrorContext,
  });

  factory TransferImportRow({
    required int lineNumber,
    required String groupId,
    required _i2.TransferImportRowStatus status,
    required _i3.TransferImportRowResolution resolution,
    int? existingInvestmentId,
    String? existingInvestmentName,
    String? newInvestmentName,
    int? newInvestmentWithdrawalRuleId,
    _i4.Asset? asset,
    List<_i4.Asset>? assetCandidates,
    double? quantity,
    double? amount,
    DateTime? date,
    _i5.TransferImportRowError? investmentErrorKey,
    String? investmentErrorContext,
    _i5.TransferImportRowError? rowErrorKey,
    String? rowErrorContext,
  }) = _TransferImportRowImpl;

  factory TransferImportRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return TransferImportRow(
      lineNumber: jsonSerialization['lineNumber'] as int,
      groupId: jsonSerialization['groupId'] as String,
      status: _i2.TransferImportRowStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      resolution: _i3.TransferImportRowResolution.fromJson(
        (jsonSerialization['resolution'] as String),
      ),
      existingInvestmentId: jsonSerialization['existingInvestmentId'] as int?,
      existingInvestmentName:
          jsonSerialization['existingInvestmentName'] as String?,
      newInvestmentName: jsonSerialization['newInvestmentName'] as String?,
      newInvestmentWithdrawalRuleId:
          jsonSerialization['newInvestmentWithdrawalRuleId'] as int?,
      asset: jsonSerialization['asset'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Asset>(jsonSerialization['asset']),
      assetCandidates: jsonSerialization['assetCandidates'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.Asset>>(
              jsonSerialization['assetCandidates'],
            ),
      quantity: (jsonSerialization['quantity'] as num?)?.toDouble(),
      amount: (jsonSerialization['amount'] as num?)?.toDouble(),
      date: jsonSerialization['date'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      investmentErrorKey: jsonSerialization['investmentErrorKey'] == null
          ? null
          : _i5.TransferImportRowError.fromJson(
              (jsonSerialization['investmentErrorKey'] as String),
            ),
      investmentErrorContext:
          jsonSerialization['investmentErrorContext'] as String?,
      rowErrorKey: jsonSerialization['rowErrorKey'] == null
          ? null
          : _i5.TransferImportRowError.fromJson(
              (jsonSerialization['rowErrorKey'] as String),
            ),
      rowErrorContext: jsonSerialization['rowErrorContext'] as String?,
    );
  }

  int lineNumber;

  String groupId;

  _i2.TransferImportRowStatus status;

  _i3.TransferImportRowResolution resolution;

  int? existingInvestmentId;

  String? existingInvestmentName;

  String? newInvestmentName;

  int? newInvestmentWithdrawalRuleId;

  _i4.Asset? asset;

  List<_i4.Asset>? assetCandidates;

  double? quantity;

  double? amount;

  DateTime? date;

  _i5.TransferImportRowError? investmentErrorKey;

  String? investmentErrorContext;

  _i5.TransferImportRowError? rowErrorKey;

  String? rowErrorContext;

  /// Returns a shallow copy of this [TransferImportRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TransferImportRow copyWith({
    int? lineNumber,
    String? groupId,
    _i2.TransferImportRowStatus? status,
    _i3.TransferImportRowResolution? resolution,
    int? existingInvestmentId,
    String? existingInvestmentName,
    String? newInvestmentName,
    int? newInvestmentWithdrawalRuleId,
    _i4.Asset? asset,
    List<_i4.Asset>? assetCandidates,
    double? quantity,
    double? amount,
    DateTime? date,
    _i5.TransferImportRowError? investmentErrorKey,
    String? investmentErrorContext,
    _i5.TransferImportRowError? rowErrorKey,
    String? rowErrorContext,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TransferImportRow',
      'lineNumber': lineNumber,
      'groupId': groupId,
      'status': status.toJson(),
      'resolution': resolution.toJson(),
      if (existingInvestmentId != null)
        'existingInvestmentId': existingInvestmentId,
      if (existingInvestmentName != null)
        'existingInvestmentName': existingInvestmentName,
      if (newInvestmentName != null) 'newInvestmentName': newInvestmentName,
      if (newInvestmentWithdrawalRuleId != null)
        'newInvestmentWithdrawalRuleId': newInvestmentWithdrawalRuleId,
      if (asset != null) 'asset': asset?.toJson(),
      if (assetCandidates != null)
        'assetCandidates': assetCandidates?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (quantity != null) 'quantity': quantity,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date?.toJson(),
      if (investmentErrorKey != null)
        'investmentErrorKey': investmentErrorKey?.toJson(),
      if (investmentErrorContext != null)
        'investmentErrorContext': investmentErrorContext,
      if (rowErrorKey != null) 'rowErrorKey': rowErrorKey?.toJson(),
      if (rowErrorContext != null) 'rowErrorContext': rowErrorContext,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransferImportRowImpl extends TransferImportRow {
  _TransferImportRowImpl({
    required int lineNumber,
    required String groupId,
    required _i2.TransferImportRowStatus status,
    required _i3.TransferImportRowResolution resolution,
    int? existingInvestmentId,
    String? existingInvestmentName,
    String? newInvestmentName,
    int? newInvestmentWithdrawalRuleId,
    _i4.Asset? asset,
    List<_i4.Asset>? assetCandidates,
    double? quantity,
    double? amount,
    DateTime? date,
    _i5.TransferImportRowError? investmentErrorKey,
    String? investmentErrorContext,
    _i5.TransferImportRowError? rowErrorKey,
    String? rowErrorContext,
  }) : super._(
         lineNumber: lineNumber,
         groupId: groupId,
         status: status,
         resolution: resolution,
         existingInvestmentId: existingInvestmentId,
         existingInvestmentName: existingInvestmentName,
         newInvestmentName: newInvestmentName,
         newInvestmentWithdrawalRuleId: newInvestmentWithdrawalRuleId,
         asset: asset,
         assetCandidates: assetCandidates,
         quantity: quantity,
         amount: amount,
         date: date,
         investmentErrorKey: investmentErrorKey,
         investmentErrorContext: investmentErrorContext,
         rowErrorKey: rowErrorKey,
         rowErrorContext: rowErrorContext,
       );

  /// Returns a shallow copy of this [TransferImportRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TransferImportRow copyWith({
    int? lineNumber,
    String? groupId,
    _i2.TransferImportRowStatus? status,
    _i3.TransferImportRowResolution? resolution,
    Object? existingInvestmentId = _Undefined,
    Object? existingInvestmentName = _Undefined,
    Object? newInvestmentName = _Undefined,
    Object? newInvestmentWithdrawalRuleId = _Undefined,
    Object? asset = _Undefined,
    Object? assetCandidates = _Undefined,
    Object? quantity = _Undefined,
    Object? amount = _Undefined,
    Object? date = _Undefined,
    Object? investmentErrorKey = _Undefined,
    Object? investmentErrorContext = _Undefined,
    Object? rowErrorKey = _Undefined,
    Object? rowErrorContext = _Undefined,
  }) {
    return TransferImportRow(
      lineNumber: lineNumber ?? this.lineNumber,
      groupId: groupId ?? this.groupId,
      status: status ?? this.status,
      resolution: resolution ?? this.resolution,
      existingInvestmentId: existingInvestmentId is int?
          ? existingInvestmentId
          : this.existingInvestmentId,
      existingInvestmentName: existingInvestmentName is String?
          ? existingInvestmentName
          : this.existingInvestmentName,
      newInvestmentName: newInvestmentName is String?
          ? newInvestmentName
          : this.newInvestmentName,
      newInvestmentWithdrawalRuleId: newInvestmentWithdrawalRuleId is int?
          ? newInvestmentWithdrawalRuleId
          : this.newInvestmentWithdrawalRuleId,
      asset: asset is _i4.Asset? ? asset : this.asset?.copyWith(),
      assetCandidates: assetCandidates is List<_i4.Asset>?
          ? assetCandidates
          : this.assetCandidates?.map((e0) => e0.copyWith()).toList(),
      quantity: quantity is double? ? quantity : this.quantity,
      amount: amount is double? ? amount : this.amount,
      date: date is DateTime? ? date : this.date,
      investmentErrorKey: investmentErrorKey is _i5.TransferImportRowError?
          ? investmentErrorKey
          : this.investmentErrorKey,
      investmentErrorContext: investmentErrorContext is String?
          ? investmentErrorContext
          : this.investmentErrorContext,
      rowErrorKey: rowErrorKey is _i5.TransferImportRowError?
          ? rowErrorKey
          : this.rowErrorKey,
      rowErrorContext: rowErrorContext is String?
          ? rowErrorContext
          : this.rowErrorContext,
    );
  }
}

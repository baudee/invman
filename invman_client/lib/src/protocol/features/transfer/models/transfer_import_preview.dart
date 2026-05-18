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
import '../../../features/transfer/models/transfer_import_row.dart' as _i2;
import '../../../features/transfer/models/transfer_import_global_error.dart'
    as _i3;
import 'package:invman_client/src/protocol/protocol.dart' as _i4;

abstract class TransferImportPreview implements _i1.SerializableModel {
  TransferImportPreview._({
    required this.rows,
    this.globalErrorKey,
    this.globalErrorContext,
  });

  factory TransferImportPreview({
    required List<_i2.TransferImportRow> rows,
    _i3.TransferImportGlobalError? globalErrorKey,
    String? globalErrorContext,
  }) = _TransferImportPreviewImpl;

  factory TransferImportPreview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TransferImportPreview(
      rows: _i4.Protocol().deserialize<List<_i2.TransferImportRow>>(
        jsonSerialization['rows'],
      ),
      globalErrorKey: jsonSerialization['globalErrorKey'] == null
          ? null
          : _i3.TransferImportGlobalError.fromJson(
              (jsonSerialization['globalErrorKey'] as String),
            ),
      globalErrorContext: jsonSerialization['globalErrorContext'] as String?,
    );
  }

  List<_i2.TransferImportRow> rows;

  _i3.TransferImportGlobalError? globalErrorKey;

  String? globalErrorContext;

  /// Returns a shallow copy of this [TransferImportPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TransferImportPreview copyWith({
    List<_i2.TransferImportRow>? rows,
    _i3.TransferImportGlobalError? globalErrorKey,
    String? globalErrorContext,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TransferImportPreview',
      'rows': rows.toJson(valueToJson: (v) => v.toJson()),
      if (globalErrorKey != null) 'globalErrorKey': globalErrorKey?.toJson(),
      if (globalErrorContext != null) 'globalErrorContext': globalErrorContext,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransferImportPreviewImpl extends TransferImportPreview {
  _TransferImportPreviewImpl({
    required List<_i2.TransferImportRow> rows,
    _i3.TransferImportGlobalError? globalErrorKey,
    String? globalErrorContext,
  }) : super._(
         rows: rows,
         globalErrorKey: globalErrorKey,
         globalErrorContext: globalErrorContext,
       );

  /// Returns a shallow copy of this [TransferImportPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TransferImportPreview copyWith({
    List<_i2.TransferImportRow>? rows,
    Object? globalErrorKey = _Undefined,
    Object? globalErrorContext = _Undefined,
  }) {
    return TransferImportPreview(
      rows: rows ?? this.rows.map((e0) => e0.copyWith()).toList(),
      globalErrorKey: globalErrorKey is _i3.TransferImportGlobalError?
          ? globalErrorKey
          : this.globalErrorKey,
      globalErrorContext: globalErrorContext is String?
          ? globalErrorContext
          : this.globalErrorContext,
    );
  }
}

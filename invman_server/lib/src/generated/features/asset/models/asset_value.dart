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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class AssetValue implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AssetValue._({
    required this.value,
    required this.timestamp,
  });

  factory AssetValue({
    required double value,
    required DateTime timestamp,
  }) = _AssetValueImpl;

  factory AssetValue.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssetValue(
      value: (jsonSerialization['value'] as num).toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  double value;

  DateTime timestamp;

  /// Returns a shallow copy of this [AssetValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssetValue copyWith({
    double? value,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssetValue',
      'value': value,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssetValue',
      'value': value,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AssetValueImpl extends AssetValue {
  _AssetValueImpl({
    required double value,
    required DateTime timestamp,
  }) : super._(
         value: value,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [AssetValue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssetValue copyWith({
    double? value,
    DateTime? timestamp,
  }) {
    return AssetValue(
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

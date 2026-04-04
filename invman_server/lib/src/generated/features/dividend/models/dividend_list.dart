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
import '../../../features/dividend/models/dividend_value.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class DividendList implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DividendList._({required this.values});

  factory DividendList({required List<_i2.DividendValue> values}) = _DividendListImpl;

  factory DividendList.fromJson(Map<String, dynamic> jsonSerialization) {
    return DividendList(
      values: _i3.Protocol().deserialize<List<_i2.DividendValue>>(
        jsonSerialization['values'],
      ),
    );
  }

  List<_i2.DividendValue> values;

  /// Returns a shallow copy of this [DividendList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DividendList copyWith({List<_i2.DividendValue>? values});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DividendList',
      'values': values.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DividendListImpl extends DividendList {
  _DividendListImpl({required List<_i2.DividendValue> values}) : super._(values: values);

  /// Returns a shallow copy of this [DividendList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DividendList copyWith({List<_i2.DividendValue>? values}) {
    return DividendList(
      values: values ?? this.values.map((e0) => e0.copyWith()).toList(),
    );
  }
}

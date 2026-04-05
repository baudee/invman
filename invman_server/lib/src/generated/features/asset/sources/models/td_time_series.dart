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
import '../../../../features/asset/sources/models/td_time_series_value.dart'
    as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class TwelveDataTimeSeries
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TwelveDataTimeSeries._({
    required this.meta,
    required this.values,
  });

  factory TwelveDataTimeSeries({
    required Map<String, String?> meta,
    required List<_i2.TwelveDataTimeSeriesValue> values,
  }) = _TwelveDataTimeSeriesImpl;

  factory TwelveDataTimeSeries.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TwelveDataTimeSeries(
      meta: _i3.Protocol().deserialize<Map<String, String?>>(
        jsonSerialization['meta'],
      ),
      values: _i3.Protocol().deserialize<List<_i2.TwelveDataTimeSeriesValue>>(
        jsonSerialization['values'],
      ),
    );
  }

  Map<String, String?> meta;

  List<_i2.TwelveDataTimeSeriesValue> values;

  /// Returns a shallow copy of this [TwelveDataTimeSeries]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TwelveDataTimeSeries copyWith({
    Map<String, String?>? meta,
    List<_i2.TwelveDataTimeSeriesValue>? values,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TwelveDataTimeSeries',
      'meta': meta.toJson(),
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

class _TwelveDataTimeSeriesImpl extends TwelveDataTimeSeries {
  _TwelveDataTimeSeriesImpl({
    required Map<String, String?> meta,
    required List<_i2.TwelveDataTimeSeriesValue> values,
  }) : super._(
         meta: meta,
         values: values,
       );

  /// Returns a shallow copy of this [TwelveDataTimeSeries]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TwelveDataTimeSeries copyWith({
    Map<String, String?>? meta,
    List<_i2.TwelveDataTimeSeriesValue>? values,
  }) {
    return TwelveDataTimeSeries(
      meta:
          meta ??
          this.meta.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      values: values ?? this.values.map((e0) => e0.copyWith()).toList(),
    );
  }
}

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
import '../../../../features/dividend/sources/models/td_dividend_value.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class TwelveDataDividends implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TwelveDataDividends._({
    required this.meta,
    required this.dividends,
  });

  factory TwelveDataDividends({
    required Map<String, String?> meta,
    required List<_i2.TwelveDataDividendValue> dividends,
  }) = _TwelveDataDividendsImpl;

  factory TwelveDataDividends.fromJson(Map<String, dynamic> jsonSerialization) {
    return TwelveDataDividends(
      meta: _i3.Protocol().deserialize<Map<String, String?>>(
        jsonSerialization['meta'],
      ),
      dividends: _i3.Protocol().deserialize<List<_i2.TwelveDataDividendValue>>(
        jsonSerialization['dividends'],
      ),
    );
  }

  Map<String, String?> meta;

  List<_i2.TwelveDataDividendValue> dividends;

  /// Returns a shallow copy of this [TwelveDataDividends]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TwelveDataDividends copyWith({
    Map<String, String?>? meta,
    List<_i2.TwelveDataDividendValue>? dividends,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TwelveDataDividends',
      'meta': meta.toJson(),
      'dividends': dividends.toJson(valueToJson: (v) => v.toJson()),
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

class _TwelveDataDividendsImpl extends TwelveDataDividends {
  _TwelveDataDividendsImpl({
    required Map<String, String?> meta,
    required List<_i2.TwelveDataDividendValue> dividends,
  }) : super._(
         meta: meta,
         dividends: dividends,
       );

  /// Returns a shallow copy of this [TwelveDataDividends]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TwelveDataDividends copyWith({
    Map<String, String?>? meta,
    List<_i2.TwelveDataDividendValue>? dividends,
  }) {
    return TwelveDataDividends(
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
      dividends: dividends ?? this.dividends.map((e0) => e0.copyWith()).toList(),
    );
  }
}

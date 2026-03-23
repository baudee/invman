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
import '../../stock/models/stock_type.dart' as _i2;

abstract class StockFilter
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StockFilter._({
    this.type,
    this.query,
    bool? favorite,
  }) : favorite = favorite ?? false;

  factory StockFilter({
    _i2.StockType? type,
    String? query,
    bool? favorite,
  }) = _StockFilterImpl;

  factory StockFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockFilter(
      type: jsonSerialization['type'] == null
          ? null
          : _i2.StockType.fromJson((jsonSerialization['type'] as String)),
      query: jsonSerialization['query'] as String?,
      favorite: jsonSerialization['favorite'] as bool?,
    );
  }

  _i2.StockType? type;

  String? query;

  bool favorite;

  /// Returns a shallow copy of this [StockFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StockFilter copyWith({
    _i2.StockType? type,
    String? query,
    bool? favorite,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockFilter',
      if (type != null) 'type': type?.toJson(),
      if (query != null) 'query': query,
      'favorite': favorite,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StockFilter',
      if (type != null) 'type': type?.toJson(),
      if (query != null) 'query': query,
      'favorite': favorite,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StockFilterImpl extends StockFilter {
  _StockFilterImpl({
    _i2.StockType? type,
    String? query,
    bool? favorite,
  }) : super._(
         type: type,
         query: query,
         favorite: favorite,
       );

  /// Returns a shallow copy of this [StockFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StockFilter copyWith({
    Object? type = _Undefined,
    Object? query = _Undefined,
    bool? favorite,
  }) {
    return StockFilter(
      type: type is _i2.StockType? ? type : this.type,
      query: query is String? ? query : this.query,
      favorite: favorite ?? this.favorite,
    );
  }
}

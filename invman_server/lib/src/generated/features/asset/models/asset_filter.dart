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
import '../../../features/asset/models/asset_type.dart' as _i2;

abstract class AssetFilter
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AssetFilter._({
    this.type,
    String? query,
    bool? favorite,
    this.exchange,
    this.currencyId,
  }) : query = query ?? '',
       favorite = favorite ?? false;

  factory AssetFilter({
    _i2.AssetType? type,
    String? query,
    bool? favorite,
    String? exchange,
    int? currencyId,
  }) = _AssetFilterImpl;

  factory AssetFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssetFilter(
      type: jsonSerialization['type'] == null
          ? null
          : _i2.AssetType.fromJson((jsonSerialization['type'] as String)),
      query: jsonSerialization['query'] as String?,
      favorite: jsonSerialization['favorite'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['favorite']),
      exchange: jsonSerialization['exchange'] as String?,
      currencyId: jsonSerialization['currencyId'] as int?,
    );
  }

  _i2.AssetType? type;

  String query;

  bool favorite;

  String? exchange;

  int? currencyId;

  /// Returns a shallow copy of this [AssetFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssetFilter copyWith({
    _i2.AssetType? type,
    String? query,
    bool? favorite,
    String? exchange,
    int? currencyId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssetFilter',
      if (type != null) 'type': type?.toJson(),
      'query': query,
      'favorite': favorite,
      if (exchange != null) 'exchange': exchange,
      if (currencyId != null) 'currencyId': currencyId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssetFilter',
      if (type != null) 'type': type?.toJson(),
      'query': query,
      'favorite': favorite,
      if (exchange != null) 'exchange': exchange,
      if (currencyId != null) 'currencyId': currencyId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetFilterImpl extends AssetFilter {
  _AssetFilterImpl({
    _i2.AssetType? type,
    String? query,
    bool? favorite,
    String? exchange,
    int? currencyId,
  }) : super._(
         type: type,
         query: query,
         favorite: favorite,
         exchange: exchange,
         currencyId: currencyId,
       );

  /// Returns a shallow copy of this [AssetFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssetFilter copyWith({
    Object? type = _Undefined,
    String? query,
    bool? favorite,
    Object? exchange = _Undefined,
    Object? currencyId = _Undefined,
  }) {
    return AssetFilter(
      type: type is _i2.AssetType? ? type : this.type,
      query: query ?? this.query,
      favorite: favorite ?? this.favorite,
      exchange: exchange is String? ? exchange : this.exchange,
      currencyId: currencyId is int? ? currencyId : this.currencyId,
    );
  }
}

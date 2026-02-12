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
import '../../protocol.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import '../../stock/models/stock.dart' as _i3;
import 'package:invman_server/src/generated/protocol.dart' as _i4;

abstract class StockList extends _i1.PaginationList
    implements _i2.SerializableModel, _i2.ProtocolSerialization {
  StockList._({
    required super.count,
    required super.page,
    required super.limit,
    required super.numPages,
    required super.canLoadMore,
    required this.results,
  });

  factory StockList({
    required int count,
    required int page,
    required int limit,
    required int numPages,
    required bool canLoadMore,
    required List<_i3.Stock> results,
  }) = _StockListImpl;

  factory StockList.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockList(
      count: jsonSerialization['count'] as int,
      page: jsonSerialization['page'] as int,
      limit: jsonSerialization['limit'] as int,
      numPages: jsonSerialization['numPages'] as int,
      canLoadMore: jsonSerialization['canLoadMore'] as bool,
      results: _i4.Protocol().deserialize<List<_i3.Stock>>(
        jsonSerialization['results'],
      ),
    );
  }

  List<_i3.Stock> results;

  /// Returns a shallow copy of this [StockList]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  StockList copyWith({
    int? count,
    int? page,
    int? limit,
    int? numPages,
    bool? canLoadMore,
    List<_i3.Stock>? results,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockList',
      'count': count,
      'page': page,
      'limit': limit,
      'numPages': numPages,
      'canLoadMore': canLoadMore,
      'results': results.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StockList',
      'count': count,
      'page': page,
      'limit': limit,
      'numPages': numPages,
      'canLoadMore': canLoadMore,
      'results': results.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _StockListImpl extends StockList {
  _StockListImpl({
    required int count,
    required int page,
    required int limit,
    required int numPages,
    required bool canLoadMore,
    required List<_i3.Stock> results,
  }) : super._(
         count: count,
         page: page,
         limit: limit,
         numPages: numPages,
         canLoadMore: canLoadMore,
         results: results,
       );

  /// Returns a shallow copy of this [StockList]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  StockList copyWith({
    int? count,
    int? page,
    int? limit,
    int? numPages,
    bool? canLoadMore,
    List<_i3.Stock>? results,
  }) {
    return StockList(
      count: count ?? this.count,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      numPages: numPages ?? this.numPages,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      results: results ?? this.results.map((e0) => e0.copyWith()).toList(),
    );
  }
}

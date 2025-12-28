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
import '../../transfer/models/transfer.dart' as _i2;
import 'package:invman_server/src/generated/protocol.dart' as _i3;

abstract class TransferList
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TransferList._({
    required this.count,
    required this.results,
    required this.page,
    required this.limit,
    required this.numPages,
    required this.canLoadMore,
  });

  factory TransferList({
    required int count,
    required List<_i2.Transfer> results,
    required int page,
    required int limit,
    required int numPages,
    required bool canLoadMore,
  }) = _TransferListImpl;

  factory TransferList.fromJson(Map<String, dynamic> jsonSerialization) {
    return TransferList(
      count: jsonSerialization['count'] as int,
      results: _i3.Protocol().deserialize<List<_i2.Transfer>>(
        jsonSerialization['results'],
      ),
      page: jsonSerialization['page'] as int,
      limit: jsonSerialization['limit'] as int,
      numPages: jsonSerialization['numPages'] as int,
      canLoadMore: jsonSerialization['canLoadMore'] as bool,
    );
  }

  int count;

  List<_i2.Transfer> results;

  int page;

  int limit;

  int numPages;

  bool canLoadMore;

  /// Returns a shallow copy of this [TransferList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TransferList copyWith({
    int? count,
    List<_i2.Transfer>? results,
    int? page,
    int? limit,
    int? numPages,
    bool? canLoadMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TransferList',
      'count': count,
      'results': results.toJson(valueToJson: (v) => v.toJson()),
      'page': page,
      'limit': limit,
      'numPages': numPages,
      'canLoadMore': canLoadMore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TransferList',
      'count': count,
      'results': results.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'page': page,
      'limit': limit,
      'numPages': numPages,
      'canLoadMore': canLoadMore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TransferListImpl extends TransferList {
  _TransferListImpl({
    required int count,
    required List<_i2.Transfer> results,
    required int page,
    required int limit,
    required int numPages,
    required bool canLoadMore,
  }) : super._(
         count: count,
         results: results,
         page: page,
         limit: limit,
         numPages: numPages,
         canLoadMore: canLoadMore,
       );

  /// Returns a shallow copy of this [TransferList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TransferList copyWith({
    int? count,
    List<_i2.Transfer>? results,
    int? page,
    int? limit,
    int? numPages,
    bool? canLoadMore,
  }) {
    return TransferList(
      count: count ?? this.count,
      results: results ?? this.results.map((e0) => e0.copyWith()).toList(),
      page: page ?? this.page,
      limit: limit ?? this.limit,
      numPages: numPages ?? this.numPages,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

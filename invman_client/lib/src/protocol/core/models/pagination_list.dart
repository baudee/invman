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

class PaginationList implements _i1.SerializableModel {
  PaginationList({
    required this.count,
    required this.page,
    required this.limit,
    required this.numPages,
    required this.canLoadMore,
  });

  factory PaginationList.fromJson(Map<String, dynamic> jsonSerialization) {
    return PaginationList(
      count: jsonSerialization['count'] as int,
      page: jsonSerialization['page'] as int,
      limit: jsonSerialization['limit'] as int,
      numPages: jsonSerialization['numPages'] as int,
      canLoadMore: jsonSerialization['canLoadMore'] as bool,
    );
  }

  int count;

  int page;

  int limit;

  int numPages;

  bool canLoadMore;

  /// Returns a shallow copy of this [PaginationList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PaginationList copyWith({
    int? count,
    int? page,
    int? limit,
    int? numPages,
    bool? canLoadMore,
  }) {
    return PaginationList(
      count: count ?? this.count,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      numPages: numPages ?? this.numPages,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PaginationList',
      'count': count,
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

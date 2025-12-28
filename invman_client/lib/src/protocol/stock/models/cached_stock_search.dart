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
import '../../stock/models/stock.dart' as _i2;
import 'package:invman_client/src/protocol/protocol.dart' as _i3;

abstract class CachedStockSearch implements _i1.SerializableModel {
  CachedStockSearch._({required this.stocks});

  factory CachedStockSearch({required List<_i2.Stock> stocks}) =
      _CachedStockSearchImpl;

  factory CachedStockSearch.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachedStockSearch(
      stocks: _i3.Protocol().deserialize<List<_i2.Stock>>(
        jsonSerialization['stocks'],
      ),
    );
  }

  List<_i2.Stock> stocks;

  /// Returns a shallow copy of this [CachedStockSearch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CachedStockSearch copyWith({List<_i2.Stock>? stocks});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedStockSearch',
      'stocks': stocks.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CachedStockSearchImpl extends CachedStockSearch {
  _CachedStockSearchImpl({required List<_i2.Stock> stocks})
    : super._(stocks: stocks);

  /// Returns a shallow copy of this [CachedStockSearch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CachedStockSearch copyWith({List<_i2.Stock>? stocks}) {
    return CachedStockSearch(
      stocks: stocks ?? this.stocks.map((e0) => e0.copyWith()).toList(),
    );
  }
}

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../stock/models/stock.dart' as _i2;

abstract class Investment implements _i1.SerializableModel {
  Investment._({
    required this.stock,
    required this.investAmount,
    required this.withdrawAmount,
  });

  factory Investment({
    required _i2.Stock stock,
    required int investAmount,
    required int withdrawAmount,
  }) = _InvestmentImpl;

  factory Investment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Investment(
      stock: _i2.Stock.fromJson(
          (jsonSerialization['stock'] as Map<String, dynamic>)),
      investAmount: jsonSerialization['investAmount'] as int,
      withdrawAmount: jsonSerialization['withdrawAmount'] as int,
    );
  }

  _i2.Stock stock;

  int investAmount;

  int withdrawAmount;

  Investment copyWith({
    _i2.Stock? stock,
    int? investAmount,
    int? withdrawAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'stock': stock.toJson(),
      'investAmount': investAmount,
      'withdrawAmount': withdrawAmount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _InvestmentImpl extends Investment {
  _InvestmentImpl({
    required _i2.Stock stock,
    required int investAmount,
    required int withdrawAmount,
  }) : super._(
          stock: stock,
          investAmount: investAmount,
          withdrawAmount: withdrawAmount,
        );

  @override
  Investment copyWith({
    _i2.Stock? stock,
    int? investAmount,
    int? withdrawAmount,
  }) {
    return Investment(
      stock: stock ?? this.stock.copyWith(),
      investAmount: investAmount ?? this.investAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
    );
  }
}

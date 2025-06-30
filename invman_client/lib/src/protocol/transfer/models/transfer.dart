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
import '../../investment/models/investment.dart' as _i2;

abstract class Transfer implements _i1.SerializableModel {
  Transfer._({
    this.id,
    required this.investmentId,
    this.investment,
    required this.quantity,
    required this.amount,
  });

  factory Transfer({
    int? id,
    required int investmentId,
    _i2.Investment? investment,
    required double quantity,
    required int amount,
  }) = _TransferImpl;

  factory Transfer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transfer(
      id: jsonSerialization['id'] as int?,
      investmentId: jsonSerialization['investmentId'] as int,
      investment: jsonSerialization['investment'] == null
          ? null
          : _i2.Investment.fromJson(
              (jsonSerialization['investment'] as Map<String, dynamic>)),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      amount: jsonSerialization['amount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int investmentId;

  _i2.Investment? investment;

  double quantity;

  int amount;

  Transfer copyWith({
    int? id,
    int? investmentId,
    _i2.Investment? investment,
    double? quantity,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'investmentId': investmentId,
      if (investment != null) 'investment': investment?.toJson(),
      'quantity': quantity,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransferImpl extends Transfer {
  _TransferImpl({
    int? id,
    required int investmentId,
    _i2.Investment? investment,
    required double quantity,
    required int amount,
  }) : super._(
          id: id,
          investmentId: investmentId,
          investment: investment,
          quantity: quantity,
          amount: amount,
        );

  @override
  Transfer copyWith({
    Object? id = _Undefined,
    int? investmentId,
    Object? investment = _Undefined,
    double? quantity,
    int? amount,
  }) {
    return Transfer(
      id: id is int? ? id : this.id,
      investmentId: investmentId ?? this.investmentId,
      investment: investment is _i2.Investment?
          ? investment
          : this.investment?.copyWith(),
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
    );
  }
}

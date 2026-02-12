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
import '../../investment/models/investment.dart' as _i2;
import 'package:invman_client/src/protocol/protocol.dart' as _i3;

abstract class Transfer implements _i1.SerializableModel {
  Transfer._({
    this.id,
    required this.investmentId,
    this.investment,
    required this.quantity,
    required this.amount,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transfer({
    int? id,
    required int investmentId,
    _i2.Investment? investment,
    required double quantity,
    required double amount,
    DateTime? createdAt,
  }) = _TransferImpl;

  factory Transfer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transfer(
      id: jsonSerialization['id'] as int?,
      investmentId: jsonSerialization['investmentId'] as int,
      investment: jsonSerialization['investment'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Investment>(
              jsonSerialization['investment'],
            ),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int investmentId;

  _i2.Investment? investment;

  double quantity;

  double amount;

  DateTime createdAt;

  /// Returns a shallow copy of this [Transfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transfer copyWith({
    int? id,
    int? investmentId,
    _i2.Investment? investment,
    double? quantity,
    double? amount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Transfer',
      if (id != null) 'id': id,
      'investmentId': investmentId,
      if (investment != null) 'investment': investment?.toJson(),
      'quantity': quantity,
      'amount': amount,
      'createdAt': createdAt.toJson(),
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
    required double amount,
    DateTime? createdAt,
  }) : super._(
         id: id,
         investmentId: investmentId,
         investment: investment,
         quantity: quantity,
         amount: amount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Transfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transfer copyWith({
    Object? id = _Undefined,
    int? investmentId,
    Object? investment = _Undefined,
    double? quantity,
    double? amount,
    DateTime? createdAt,
  }) {
    return Transfer(
      id: id is int? ? id : this.id,
      investmentId: investmentId ?? this.investmentId,
      investment: investment is _i2.Investment?
          ? investment
          : this.investment?.copyWith(),
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

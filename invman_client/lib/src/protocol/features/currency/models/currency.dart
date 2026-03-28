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

abstract class Currency implements _i1.SerializableModel {
  Currency._({
    this.id,
    required this.code,
  });

  factory Currency({
    int? id,
    required String code,
  }) = _CurrencyImpl;

  factory Currency.fromJson(Map<String, dynamic> jsonSerialization) {
    return Currency(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  /// Returns a shallow copy of this [Currency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Currency copyWith({
    int? id,
    String? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Currency',
      if (id != null) 'id': id,
      'code': code,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurrencyImpl extends Currency {
  _CurrencyImpl({
    int? id,
    required String code,
  }) : super._(
         id: id,
         code: code,
       );

  /// Returns a shallow copy of this [Currency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Currency copyWith({
    Object? id = _Undefined,
    String? code,
  }) {
    return Currency(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
    );
  }
}

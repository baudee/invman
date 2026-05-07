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

abstract class UserPermissions implements _i1.SerializableModel {
  UserPermissions._({this.investmentsLimit});

  factory UserPermissions({int? investmentsLimit}) = _UserPermissionsImpl;

  factory UserPermissions.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPermissions(
      investmentsLimit: jsonSerialization['investmentsLimit'] as int?,
    );
  }

  int? investmentsLimit;

  /// Returns a shallow copy of this [UserPermissions]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPermissions copyWith({int? investmentsLimit});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserPermissions',
      if (investmentsLimit != null) 'investmentsLimit': investmentsLimit,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPermissionsImpl extends UserPermissions {
  _UserPermissionsImpl({int? investmentsLimit})
    : super._(investmentsLimit: investmentsLimit);

  /// Returns a shallow copy of this [UserPermissions]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPermissions copyWith({Object? investmentsLimit = _Undefined}) {
    return UserPermissions(
      investmentsLimit: investmentsLimit is int?
          ? investmentsLimit
          : this.investmentsLimit,
    );
  }
}

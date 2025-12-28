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

abstract class CachedCurrencyChange
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CachedCurrencyChange._({required this.currencyChange});

  factory CachedCurrencyChange({required double currencyChange}) =
      _CachedCurrencyChangeImpl;

  factory CachedCurrencyChange.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CachedCurrencyChange(
      currencyChange: (jsonSerialization['currencyChange'] as num).toDouble(),
    );
  }

  double currencyChange;

  /// Returns a shallow copy of this [CachedCurrencyChange]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CachedCurrencyChange copyWith({double? currencyChange});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedCurrencyChange',
      'currencyChange': currencyChange,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CachedCurrencyChange',
      'currencyChange': currencyChange,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CachedCurrencyChangeImpl extends CachedCurrencyChange {
  _CachedCurrencyChangeImpl({required double currencyChange})
    : super._(currencyChange: currencyChange);

  /// Returns a shallow copy of this [CachedCurrencyChange]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CachedCurrencyChange copyWith({double? currencyChange}) {
    return CachedCurrencyChange(
      currencyChange: currencyChange ?? this.currencyChange,
    );
  }
}

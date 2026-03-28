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

enum AssetTimeHorizon implements _i1.SerializableModel {
  oneDay,
  oneWeek,
  oneMonth,
  oneYear,
  all;

  static AssetTimeHorizon fromJson(String name) {
    switch (name) {
      case 'oneDay':
        return AssetTimeHorizon.oneDay;
      case 'oneWeek':
        return AssetTimeHorizon.oneWeek;
      case 'oneMonth':
        return AssetTimeHorizon.oneMonth;
      case 'oneYear':
        return AssetTimeHorizon.oneYear;
      case 'all':
        return AssetTimeHorizon.all;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AssetTimeHorizon"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}

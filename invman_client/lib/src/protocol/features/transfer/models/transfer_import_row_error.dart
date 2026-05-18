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

enum TransferImportRowError implements _i1.SerializableModel {
  idAndNameMissing,
  invalidExistingInvestmentId,
  existingInvestmentNotFound,
  newInvestmentNameRequired,
  assetRequired,
  symbolRequired,
  noAssetForSymbol,
  multipleAssetsForSymbol,
  invalidQuantity,
  invalidAmount,
  invalidDate;

  static TransferImportRowError fromJson(String name) {
    switch (name) {
      case 'idAndNameMissing':
        return TransferImportRowError.idAndNameMissing;
      case 'invalidExistingInvestmentId':
        return TransferImportRowError.invalidExistingInvestmentId;
      case 'existingInvestmentNotFound':
        return TransferImportRowError.existingInvestmentNotFound;
      case 'newInvestmentNameRequired':
        return TransferImportRowError.newInvestmentNameRequired;
      case 'assetRequired':
        return TransferImportRowError.assetRequired;
      case 'symbolRequired':
        return TransferImportRowError.symbolRequired;
      case 'noAssetForSymbol':
        return TransferImportRowError.noAssetForSymbol;
      case 'multipleAssetsForSymbol':
        return TransferImportRowError.multipleAssetsForSymbol;
      case 'invalidQuantity':
        return TransferImportRowError.invalidQuantity;
      case 'invalidAmount':
        return TransferImportRowError.invalidAmount;
      case 'invalidDate':
        return TransferImportRowError.invalidDate;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "TransferImportRowError"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}

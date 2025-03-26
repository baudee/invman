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

abstract class FmpStockInfo implements _i1.SerializableModel {
  FmpStockInfo._({
    this.symbol,
    this.name,
    this.currency,
    this.stockExchange,
    this.exchangeShortName,
  });

  factory FmpStockInfo({
    String? symbol,
    String? name,
    String? currency,
    String? stockExchange,
    String? exchangeShortName,
  }) = _FmpStockInfoImpl;

  factory FmpStockInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return FmpStockInfo(
      symbol: jsonSerialization['symbol'] as String?,
      name: jsonSerialization['name'] as String?,
      currency: jsonSerialization['currency'] as String?,
      stockExchange: jsonSerialization['stockExchange'] as String?,
      exchangeShortName: jsonSerialization['exchangeShortName'] as String?,
    );
  }

  String? symbol;

  String? name;

  String? currency;

  String? stockExchange;

  String? exchangeShortName;

  FmpStockInfo copyWith({
    String? symbol,
    String? name,
    String? currency,
    String? stockExchange,
    String? exchangeShortName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (symbol != null) 'symbol': symbol,
      if (name != null) 'name': name,
      if (currency != null) 'currency': currency,
      if (stockExchange != null) 'stockExchange': stockExchange,
      if (exchangeShortName != null) 'exchangeShortName': exchangeShortName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FmpStockInfoImpl extends FmpStockInfo {
  _FmpStockInfoImpl({
    String? symbol,
    String? name,
    String? currency,
    String? stockExchange,
    String? exchangeShortName,
  }) : super._(
          symbol: symbol,
          name: name,
          currency: currency,
          stockExchange: stockExchange,
          exchangeShortName: exchangeShortName,
        );

  @override
  FmpStockInfo copyWith({
    Object? symbol = _Undefined,
    Object? name = _Undefined,
    Object? currency = _Undefined,
    Object? stockExchange = _Undefined,
    Object? exchangeShortName = _Undefined,
  }) {
    return FmpStockInfo(
      symbol: symbol is String? ? symbol : this.symbol,
      name: name is String? ? name : this.name,
      currency: currency is String? ? currency : this.currency,
      stockExchange:
          stockExchange is String? ? stockExchange : this.stockExchange,
      exchangeShortName: exchangeShortName is String?
          ? exchangeShortName
          : this.exchangeShortName,
    );
  }
}

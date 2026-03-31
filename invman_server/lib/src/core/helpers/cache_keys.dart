import 'package:invman_server/src/generated/protocol.dart';

class CacheKeys {
  CacheKeys._();

  // Transfers
  static String transfersAll(int investmentId) => 'transfers_all_$investmentId';

  // Investment
  static String investmentReturns(int investmentId, InvestmentReturnInterval interval) =>
      '$investmentId-${interval.name}-returns';

  // Asset
  static String assetCurrentValue(Asset asset) =>
      asset.exchange == null ? asset.symbol : '${asset.symbol}-${asset.exchange}';

  static String assetTimeSeries(Asset asset, AssetTimeHorizon timeHorizon) =>
      '${asset.id}-${timeHorizon.name}';

  // Currency
  static String currencyDollarValue(String code) => code;

  static String currencyEodDollarValue(String code, DateTime date) =>
      '$code-${date.year}-${date.month}-${date.day}';

  // Dividends
  static String dividendsCurrent(String symbol, String? exchange) =>
      'dividends_current_${symbol}_${exchange ?? ""}';

  static String dividendsAll(String symbol, String? exchange) =>
      'dividends_all_${symbol}_${exchange ?? ""}';
}

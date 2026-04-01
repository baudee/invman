import 'package:invman_server/src/generated/protocol.dart';

class CacheKeys {
  CacheKeys._();

  // Transfers
  static String transfersAll(int investmentId) => 'transfers_all_$investmentId';

  // Investment
  static String investmentReturns(int investmentId, InvestmentReturnInterval interval) =>
      'returns_${investmentId}_${interval.name}';

  // Asset
  static String assetCurrentValue(Asset asset) => 'asset_current_value_${asset.id}';

  static String assetTimeSeries(Asset asset, AssetTimeHorizon timeHorizon) => '${asset.id}-${timeHorizon.name}';

  static String exchangesList = 'exchanges_list';

  // Currency
  static String currencyDollarValue(String code) => "currency_dollar_value_$code";

  static String currencyEodDollarValue(String code, DateTime date) =>
      "currency_eod_dollar_value_$code-${date.year}-${date.month}-${date.day}";

  // Dividends
  static String dividendsCurrent(Asset asset) => 'dividends_current_${asset.id}';

  static String dividendsAll(Asset asset) => 'dividends_all_${asset.id}';
}

import 'package:invman_server/src/generated/protocol.dart';

class CacheKeys {
  CacheKeys._();

  // Transfers
  static String transfersAll(int investmentId) => 'transfers_all_$investmentId';

  // Asset
  static String assetCurrentValue(Asset asset) => 'asset_current_value_${asset.id}';

  static String assetEodValue(Asset asset, DateTime date) =>
      'asset_eod_${asset.id}-${date.year}-${date.month}-${date.day}';

  static String assetTimeSeries(Asset asset, AssetTimeHorizon timeHorizon) =>
      'asset_ts_${asset.id}-${timeHorizon.name}';

  // Currency
  static String currencyDollarValue(String code) => "currency_dollar_value_$code";

  static String currencyEodDollarValue(String code, DateTime date) =>
      "currency_eod_dollar_value_$code-${date.year}-${date.month}-${date.day}";

  // Dividends
  static String dividendsCurrent(Asset asset) => 'dividends_current_${asset.id}';

  static String dividendsAll(Asset asset) => 'dividends_all_${asset.id}';
}

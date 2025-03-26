import 'package:invman_server/src/generated/protocol.dart';

extension FmpStockInfoExtension on FmpStockInfo {
  Stock? toEntity() {
    if (name == null || symbol == null || currency == null || stockExchange == null || exchangeShortName == null) {
      return null;
    } else {
      return Stock(
        name: name!,
        symbol: symbol!,
        currency: currency!,
        stockExchange: stockExchange!,
        exchangeShortName: exchangeShortName!,
      );
    }
  }
}

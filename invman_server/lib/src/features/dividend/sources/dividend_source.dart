import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/core/services/services.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

abstract class DividendSource {
  Future<List<DividendValue>> getCurrentYearDividends(Session session, {required Investment investment});
  Future<List<DividendValue>> getAllDividends(Session session, {required Investment investment});
}

@LazySingleton(as: DividendSource)
class DividendSourceImpl implements DividendSource {
  final Env _env;
  final String url = "api.twelvedata.com";
  final String dividendsPath = "dividends";
  final typesWithDividends = [AssetType.stock, AssetType.etf];

  DividendSourceImpl(this._env);

  @override
  Future<List<DividendValue>> getCurrentYearDividends(Session session, {required Investment investment}) async {
    if (investment.asset == null || !typesWithDividends.contains(investment.asset!.type)) {
      return [];
    }
    final cacheKey = CacheKeys.dividendsCurrent(investment.asset!);

    DividendList? cached = await session.caches.local.get<DividendList>(cacheKey);

    if (cached == null) {
      final now = DateTime.timestamp();
      final month = now.month.toString().padLeft(2, "0");
      final day = now.day.toString().padLeft(2, "0");
      Map<String, String> queryParameters = {
        "symbol": investment.asset?.symbol ?? "",
        "apikey": _env.twelveDataApiKey,
        "start_date": "${now.year - 1}-$month-$day",
        "end_date": "${now.year}-$month-$day",
      };

      if (investment.asset?.exchange != null) {
        queryParameters["exchange"] = investment.asset!.exchange!;
      }

      final result = await ApiClientService.get(
        url: url,
        path: dividendsPath,
        queryParameters: queryParameters,
      );

      final twelveDataDividends = TwelveDataDividends.fromJson(result);
      final dividends = <DividendValue>[];
      final lastDividendAmount = twelveDataDividends.dividends.isNotEmpty
          ? twelveDataDividends.dividends.first.amount
          : 0.0;
      for (final tdDividend in twelveDataDividends.dividends) {
        DateTime date = DateTime.parse(tdDividend.exDate);
        double amount = tdDividend.amount;
        if (date.year < now.year) {
          amount = lastDividendAmount;
          date = DateTime(now.year, date.month, date.day);
        }
        dividends.add(DividendValue(amount: amount, date: date));
      }

      cached = DividendList(values: dividends);
      await session.caches.local.put(cacheKey, cached, lifetime: Duration(hours: 1));
    }

    return cached.values;
  }

  @override
  Future<List<DividendValue>> getAllDividends(Session session, {required Investment investment}) async {
    if (investment.asset == null || !typesWithDividends.contains(investment.asset!.type)) {
      return [];
    }
    final cacheKey = CacheKeys.dividendsAll(investment.asset!);

    DividendList? cached = await session.caches.local.get<DividendList>(cacheKey);

    if (cached == null) {
      Map<String, String> queryParameters = {
        "symbol": investment.asset?.symbol ?? "",
        "range": "full",
        "apikey": _env.twelveDataApiKey,
      };

      if (investment.asset?.exchange != null) {
        queryParameters["exchange"] = investment.asset!.exchange!;
      }

      final result = await ApiClientService.get(
        url: url,
        path: dividendsPath,
        queryParameters: queryParameters,
      );

      final twelveDataDividends = TwelveDataDividends.fromJson(result);
      final dividends = <DividendValue>[];
      for (final tdDividend in twelveDataDividends.dividends) {
        dividends.add(
          DividendValue(
            amount: tdDividend.amount,
            date: DateTime.parse(tdDividend.exDate),
          ),
        );
      }

      cached = DividendList(values: dividends);
      await session.caches.local.put(cacheKey, cached, lifetime: Duration(hours: 1));
    }

    return cached.values;
  }
}

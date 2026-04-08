import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/core.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

abstract class ForexValuesSource {
  Future<AssetValue> getDollarValue(Session session, {required String code});
  Future<AssetValue> getEodDollarValue(Session session, {required String code, required DateTime date});
  Future<void> preloadEodDollarValuesBulk(Session session, List<(String, DateTime)> pairs);
}

@LazySingleton(as: ForexValuesSource)
class ForexValuesSourceImpl implements ForexValuesSource {
  final Env _env;
  final String url = "api.twelvedata.com";
  final String timeSeriesPath = "time_series";
  final String eodPath = "eod";

  ForexValuesSourceImpl(this._env);

  @override
  Future<AssetValue> getDollarValue(Session session, {required String code}) async {
    final cacheKey = CacheKeys.currencyDollarValue(code);
    AssetValue? dollarValue = await session.caches.local.get(cacheKey);
    if (dollarValue == null) {
      if (code == "USD") {
        return AssetValue(value: 1, timestamp: DateTime.now());
      }

      String requestCode = code;
      if (code == "ILA") {
        requestCode = "ILS";
      }

      final result = await ApiClientService.get(
        url: url,
        path: timeSeriesPath,
        queryParameters: {
          "symbol": "USD/$requestCode",
          "interval": "1min",
          "outputsize": "1",
          "apikey": _env.twelveDataApiKey,
          "timezone": "UTC",
        },
      );

      final twelveDataTimeSeries = TwelveDataTimeSeries.fromJson(result);

      if (twelveDataTimeSeries.values.isEmpty) {
        throw ServerException(errorCode: ErrorCode.notFound);
      }

      final data = twelveDataTimeSeries.values.first;
      double value = double.parse(data.close);
      if (code == "ILA") {
        value *= 100;
      }

      dollarValue = AssetValue(value: value, timestamp: DateTime.parse(data.datetime));
      await session.caches.local.put(cacheKey, dollarValue, lifetime: Duration(seconds: 30));
    }
    return dollarValue;
  }

  @override
  Future<AssetValue> getEodDollarValue(Session session, {required String code, required DateTime date}) async {
    final cacheKey = CacheKeys.currencyEodDollarValue(code, date);
    AssetValue? dollarValue = await session.caches.local.get(cacheKey);
    if (dollarValue == null) {
      if (code == "USD") {
        return AssetValue(value: 1, timestamp: date);
      }

      String requestCode = code;
      if (code == "ILA") {
        requestCode = "ILS";
      }

      final result = await ApiClientService.get(
        url: url,
        path: eodPath,
        queryParameters: {
          "symbol": "USD/$requestCode",
          "apikey": _env.twelveDataApiKey,
          "timezone": "UTC",
          "date": date.toString(),
        },
      );

      double value = double.parse(result['close']);
      if (code == "ILA") {
        value *= 100;
      }

      dollarValue = AssetValue(value: value, timestamp: DateTime.parse(result['datetime']));
      await session.caches.local.put(cacheKey, dollarValue, lifetime: Duration(days: 30));
    }
    return dollarValue;
  }

  @override
  Future<void> preloadEodDollarValuesBulk(Session session, List<(String, DateTime)> pairs) async {
    // Deduplicate and skip USD (always returns 1, no API call needed).
    final uncached = <(String, DateTime)>{};
    for (final (code, date) in pairs) {
      if (code == 'USD') continue;
      final cached = await session.caches.local.get(CacheKeys.currencyEodDollarValue(code, date));
      if (cached == null) uncached.add((code, date));
    }

    if (uncached.isEmpty) return;

    // Chunk into groups of 40 to stay within Twelve Data's batch sub-request limit.
    final list = uncached.toList();
    for (int chunkStart = 0; chunkStart < list.length; chunkStart += 40) {
      final chunk = list.sublist(chunkStart, (chunkStart + 40).clamp(0, list.length));

      final reqIndex = <String, (String, DateTime)>{};
      final batchBody = <String, dynamic>{};

      for (int i = 0; i < chunk.length; i++) {
        final (code, date) = chunk[i];
        final reqId = 'forex_eod_$i';
        reqIndex[reqId] = (code, date);

        String requestCode = code;
        if (code == 'ILA') requestCode = 'ILS';

        final queryString = {
          'symbol': 'USD/$requestCode',
          'apikey': _env.twelveDataApiKey,
          'timezone': 'UTC',
          'date': date.toString(),
        }.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');

        batchBody[reqId] = {'url': '/$eodPath?$queryString'};
      }

      final result = await ApiClientService.post(
        url: url,
        path: 'batch',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'apikey ${_env.twelveDataApiKey}',
        },
        body: jsonEncode(batchBody),
      );

      final data = result['data'] as Map<String, dynamic>?;
      if (data == null) continue;

      for (final entry in reqIndex.entries) {
        final reqId = entry.key;
        final (code, date) = entry.value;

        final responseEntry = data[reqId] as Map<String, dynamic>?;
        if (responseEntry == null || responseEntry['status'] != 'success') continue;

        final response = responseEntry['response'] as Map<String, dynamic>?;
        if (response == null || response['close'] == null || response['datetime'] == null) continue;

        double value = double.parse(response['close']);
        if (code == 'ILA') value *= 100;

        final dollarValue = AssetValue(
          value: value,
          timestamp: DateTime.parse(response['datetime']),
        );
        await session.caches.local.put(
          CacheKeys.currencyEodDollarValue(code, date),
          dollarValue,
          lifetime: const Duration(days: 30),
        );
      }
    }
  }
}

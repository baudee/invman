import 'package:invman_server/src/core/services/http_client_service.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';

class StockApiImpl implements StockApi {
  final String baseUrl;
  Map<String, String>? headers;

  StockApiImpl({required this.baseUrl}) {
    headers = {
      "Content-Type": "application/json",
    };
  }

  @override
  Future<List<Stock>> search({required String query, int limit = 10}) async {
    final jsonResponse = await HttpClientService.get(
      url: baseUrl,
      path: "ticker/search",
      headers: headers,
      queryParameters: {
        "symbol": query,
        "limit": limit.toString(),
      },
    ) as List<dynamic>;

    final List<YFinLightStock> yfinStocks = jsonResponse.map((e) => YFinLightStock.fromJson(e)).toList();
    return yfinStocks.map((e) => e.toEntity()).whereType<Stock>().toList();
  }

  @override
  Future<int> currencyChange({required String from, required String to}) {
    // TODO: implement currencyChange
    throw UnimplementedError();
  }

  @override
  Future<Stock> get({required String symbol}) async {
    final jsonResponse = await HttpClientService.get(
      url: baseUrl,
      path: "ticker/$symbol",
      headers: headers,
    );

    final YFinStock yfinStock = YFinStock.fromJson(jsonResponse);
    return yfinStock.toEntity();
  }
}

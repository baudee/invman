import 'package:invman_server/src/core/services/api_client/api_client_service.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';

class StockClientImpl implements StockClient {
  final String baseUrl;
  Map<String, String>? headers;

  StockClientImpl({required this.baseUrl}) {
    headers = {
      "Content-Type": "application/json",
    };
  }

  @override
  Future<List<Stock>> search({required String query, int limit = 10}) async {
    final jsonResponse =
        await ApiClientService.get(
              url: baseUrl,
              path: "ticker/search",
              headers: headers,
              queryParameters: {
                "symbol": query,
                "limit": limit.toString(),
              },
              useHttps: false,
            )
            as List<dynamic>;

    final List<YFinLightStock> yfinStocks = jsonResponse.map((e) => YFinLightStock.fromJson(e)).toList();
    return yfinStocks.map((e) => e.toEntity()).whereType<Stock>().toList();
  }

  @override
  Future<double> currencyChange({required String from, required String to}) async {
    final jsonResponse = await ApiClientService.get(
      url: baseUrl,
      path: "currency/$from/$to",
      headers: headers,
      useHttps: false,
    );
    if (jsonResponse is! num) {
      throw ServerException(errorCode: ErrorCode.unknown);
    }

    return jsonResponse as double;
  }

  @override
  Future<Stock> get({required String symbol}) async {
    final jsonResponse = await ApiClientService.get(
      url: baseUrl,
      path: "ticker/$symbol",
      headers: headers,
      useHttps: false,
    );

    final YFinStock yfinStock = YFinStock.fromJson(jsonResponse);
    return yfinStock.toEntity();
  }
}

import 'package:invman_server/src/core/services/http_client_service.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';

class StockApiImpl implements StockApi {
  final String _baseUrl = "financialmodelingprep.com/api/v3";
  final String apiKey;
  Map<String, String>? headers;

  StockApiImpl({required this.apiKey}) {
    headers = {
      "Content-Type": "application/json",
    };
  }

  @override
  Future<List<Stock>> search({required String query, int limit = 10}) async {
    final jsonResponse = await HttpClientService.get(
      url: _baseUrl,
      path: "search",
      headers: headers,
      queryParameters: {
        "query": query,
        "apikey": apiKey,
        "limit": limit.toString(),
      },
    ) as List<dynamic>;

    final List<FmpStockInfo> fmpStocks = jsonResponse.map((e) => FmpStockInfo.fromJson(e)).toList();
    return fmpStocks.map((e) => e.toEntity()).whereType<Stock>().toList();
  }
}

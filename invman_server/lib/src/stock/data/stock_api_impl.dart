import 'package:invman_server/src/core/services/http_client_service.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';

class StockApiImpl implements StockApi {
  final String _baseUrl = "api.twelvedata.com";
  final String apiKey;
  Map<String, String>? headers;

  StockApiImpl({required this.apiKey}) {
    headers = {
      "Content-Type": "application/json",
      "Authorization": "apikey $apiKey",
    };
  }

  @override
  Future<List<Stock>> search({required String query}) async {
    final jsonResponse = await HttpClientService.get(
      url: _baseUrl,
      path: "symbol_search",
      headers: headers,
      queryParameters: {
        "symbol": query,
      },
    );

    final stockResponse = StockResponse.fromJson(jsonResponse);
    return stockResponse.data.map((e) => e.toStock()).toList();
  }
}

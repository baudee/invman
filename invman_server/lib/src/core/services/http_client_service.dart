import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClientService {
  static Future<dynamic> get({
    required String url,
    required String path,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final split = url.split('/');
      if (split.length > 1) {
        url = split[0];
        split.removeAt(0);
        path = '${split.join('/')}/$path';
      }
      final uri = Uri.https(url, path, queryParameters);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

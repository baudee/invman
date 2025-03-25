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
      final uri = Uri.https(url, path, queryParameters);
      print(uri);
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

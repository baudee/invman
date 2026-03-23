import 'package:http/http.dart' as http;
import 'package:invman_server/src/generated/core/exceptions/error_code.dart';
import 'dart:convert';

import 'package:invman_server/src/generated/core/exceptions/server_exception.dart';

class ApiClientService {
  static Future<dynamic> get({
    required String url,
    required String path,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool useHttps = true,
  }) async {
    final split = url.split('/');
    if (split.length > 1) {
      url = split[0];
      split.removeAt(0);
      path = '${split.join('/')}/$path';
    }
    final uri = useHttps ? Uri.https(url, path, queryParameters) : Uri.http(url, path, queryParameters);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 400) {
      throw ServerException(
        errorCode: ErrorCode.badRequest,
        message: response.body,
      );
    } else if (response.statusCode == 401) {
      throw ServerException(
        errorCode: ErrorCode.unauthorized,
        message: response.body,
      );
    } else if (response.statusCode == 403) {
      throw ServerException(
        errorCode: ErrorCode.forbidden,
        message: response.body,
      );
    } else if (response.statusCode == 404) {
      throw ServerException(
        errorCode: ErrorCode.notFound,
        message: response.body,
      );
    } else {
      throw ServerException(
        errorCode: ErrorCode.unknown,
        message: "HttpClientService status code not handled ${response.statusCode}, body: ${response.body}",
      );
    }
  }

  static Future<dynamic> post({
    required String url,
    required String path,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    bool useHttps = true,
  }) async {
    final split = url.split('/');
    if (split.length > 1) {
      url = split[0];
      split.removeAt(0);
      path = '${split.join('/')}/$path';
    }
    final uri = useHttps ? Uri.https(url, path, queryParameters) : Uri.http(url, path, queryParameters);
    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 400) {
      throw ServerException(
        errorCode: ErrorCode.badRequest,
        message: response.body,
      );
    } else if (response.statusCode == 401) {
      throw ServerException(
        errorCode: ErrorCode.unauthorized,
        message: response.body,
      );
    } else if (response.statusCode == 403) {
      throw ServerException(
        errorCode: ErrorCode.forbidden,
        message: response.body,
      );
    } else if (response.statusCode == 404) {
      throw ServerException(
        errorCode: ErrorCode.notFound,
        message: response.body,
      );
    } else {
      throw ServerException(
        errorCode: ErrorCode.unknown,
        message: "HttpClientService status code not handled ${response.statusCode}, body: ${response.body}",
      );
    }
  }
}

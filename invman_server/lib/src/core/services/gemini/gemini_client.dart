import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/api_client/api_client_service.dart';
import 'package:invman_server/src/env.dart';

@lazySingleton
class GeminiClient {
  final Env _env;

  static const _baseUrl = 'generativelanguage.googleapis.com';
  static const _model = 'gemini-2.5-flash';

  GeminiClient(this._env);

  Future<String?> prompt(String prompt) async {
    final body = {
      'contents': [
        {
          'parts': [
            {'text': prompt},
          ],
        },
      ],
      'tools': [
        {'google_search': {}},
      ],
    };

    final response = await ApiClientService.post(
      url: _baseUrl,
      path: '/v1beta/models/$_model:generateContent',
      queryParameters: {'key': 'key'},
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final jsonResponse = response as Map<String, dynamic>?;
    if (jsonResponse == null) return null;

    final candidates = jsonResponse['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) return null;

    final content = candidates[0]['content'] as Map<String, dynamic>?;
    if (content == null) return null;

    final parts = content['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) return null;

    return parts[0]['text'] as String?;
  }
}
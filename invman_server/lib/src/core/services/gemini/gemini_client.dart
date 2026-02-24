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

  Future<Map<String, dynamic>?> prompt(String prompt) async {
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
      queryParameters: {'key': _env.geminiApiKey},
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final jsonResponse = response as Map<String, dynamic>;
    final candidates = jsonResponse['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      return null;
    }

    final content = candidates[0]['content'] as Map<String, dynamic>?;
    if (content == null) {
      return null;
    }

    final parts = content['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) {
      return null;
    }

    final text = parts[0]['text'] as String?;
    if (text == null) {
      return null;
    }

    return _extractJson(text);
  }

  Map<String, dynamic>? _extractJson(String text) {
    // Try direct parse first
    try {
      return jsonDecode(text) as Map<String, dynamic>;
    } catch (_) {}

    // Try to extract JSON from markdown code block
    final jsonBlockRegex = RegExp(r'```(?:json)?\s*([\s\S]*?)```');
    final match = jsonBlockRegex.firstMatch(text);
    if (match != null) {
      try {
        return jsonDecode(match.group(1)!.trim()) as Map<String, dynamic>;
      } catch (_) {}
    }

    // Try to find JSON object in text
    final jsonObjectRegex = RegExp(r'\{[\s\S]*\}');
    final objectMatch = jsonObjectRegex.firstMatch(text);
    if (objectMatch != null) {
      try {
        return jsonDecode(objectMatch.group(0)!) as Map<String, dynamic>;
      } catch (_) {}
    }

    return null;
  }
}

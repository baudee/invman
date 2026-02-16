import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/services/api_client/api_client_service.dart';
import 'package:invman_server/src/core/services/mail/mail.dart';
import 'package:invman_server/src/env.dart';

@Injectable(as: MailServiceInterface)
class MailjetMailService implements MailServiceInterface {
  final String _apiKeyPublic;
  final String _apiKeyPrivate;
  final String _senderEmail;

  MailjetMailService(Env env)
    : _senderEmail = env.mailjetEmailSender,
      _apiKeyPrivate = env.mailjetApiKeyPrivate,
      _apiKeyPublic = env.mailjetApiKeyPublic;

  @override
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$_apiKeyPublic:$_apiKeyPrivate'))}';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": authHeader,
    };

    String content = json.encode({
      "Messages": [
        {
          "From": {"Email": _senderEmail, "Name": "Rimawari Support"},
          "To": [
            {"Email": to},
          ],
          "Subject": subject,
          "TextPart": body,
          "HTMLPart": body,
        },
      ],
    });

    await ApiClientService.post(
      url: "api.mailjet.com",
      path: "v3.1/send",
      headers: headers,
      body: content,
    );
  }
}

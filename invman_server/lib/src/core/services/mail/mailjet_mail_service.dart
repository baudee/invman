import 'dart:convert';

import 'package:invman_server/src/core/services/api_client/api_client_service.dart';
import 'package:invman_server/src/core/services/mail/mail.dart';

class MailjetMailService implements MailServiceInterface {
  final String apiKeyPublic;
  final String apiKeyPrivate;
  final String senderEmail;

  MailjetMailService({
    required this.apiKeyPublic,
    required this.apiKeyPrivate,
    required this.senderEmail,
  });

  @override
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    final authHeader = 'Basic ${base64Encode(utf8.encode('$apiKeyPublic:$apiKeyPrivate'))}';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": authHeader,
    };

    String content = json.encode({
      "Messages": [
        {
          "From": {"Email": senderEmail, "Name": "Rimawari Support"},
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

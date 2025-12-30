abstract interface class MailServiceInterface {
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  });
}

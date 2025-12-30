import 'package:dotenv/dotenv.dart';

class Env {
  late final DotEnv env;
  late final String yfinBaseUrl;
  late final String mailjetApiKeyPrivate;
  late final String mailjetApiKeyPublic;
  late final String mailjetEmailSender;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    // Fast Finance Base URL
    yfinBaseUrl = getVarFromKey('YFIN_BASE_URL');
    // Mailjet
    mailjetApiKeyPrivate = getVarFromKey('MAILJET_API_KEY_PRIVATE');
    mailjetApiKeyPublic = getVarFromKey('MAILJET_API_KEY_PUBLIC');
    mailjetEmailSender = getVarFromKey('MAILJET_EMAIL_SENDER');
  }

  String getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }
}

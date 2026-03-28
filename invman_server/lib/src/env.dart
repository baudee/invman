import 'package:dotenv/dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class Env {
  late final DotEnv env;
  late final String yfinBaseUrl;
  late final String mailjetApiKeyPrivate;
  late final String mailjetApiKeyPublic;
  late final String mailjetEmailSender;
  late final String twelveDataApiKey;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    // Mailjet
    mailjetApiKeyPrivate = _getVarFromKey('MAILJET_API_KEY_PRIVATE');
    mailjetApiKeyPublic = _getVarFromKey('MAILJET_API_KEY_PUBLIC');
    mailjetEmailSender = _getVarFromKey('MAILJET_EMAIL_SENDER');

    // API
    twelveDataApiKey = _getVarFromKey('TWELVE_DATA_API_KEY');
  }

  String _getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }
}

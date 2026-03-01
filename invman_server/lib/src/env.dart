import 'package:dotenv/dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class Env {
  late final DotEnv env;
  late final String yfinBaseUrl;
  late final String mailjetApiKeyPrivate;
  late final String mailjetApiKeyPublic;
  late final String mailjetEmailSender;
  late final String geminiApiKey;
  late final int cacheDurationDays;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    // Mailjet
    mailjetApiKeyPrivate = _getVarFromKey('MAILJET_API_KEY_PRIVATE');
    mailjetApiKeyPublic = _getVarFromKey('MAILJET_API_KEY_PUBLIC');
    mailjetEmailSender = _getVarFromKey('MAILJET_EMAIL_SENDER');

    // Gemini
    geminiApiKey = _getVarFromKey('GEMINI_API_KEY');

    // Config
    cacheDurationDays = _getIntVarFromKey('CACHE_DURATION_DAYS');
  }

  String _getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }

  int _getIntVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    final intValue = int.tryParse(env[key]!);
    if (intValue == null) {
      throw Exception("$key is not an int");
    }
    return intValue;
  }
}

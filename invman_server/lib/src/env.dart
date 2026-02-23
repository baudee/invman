import 'package:dotenv/dotenv.dart';
import 'package:injectable/injectable.dart';

enum Flavor { develop, staging, production }

@singleton
class Env {
  late final Flavor flavor;
  late final DotEnv env;
  late final String yfinBaseUrl;
  late final String mailjetApiKeyPrivate;
  late final String mailjetApiKeyPublic;
  late final String mailjetEmailSender;
  late final String geminiApiKey;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    switch (const String.fromEnvironment("APP_FLAVOR")) {
      case 'develop':
        flavor = Flavor.develop;
        break;
      case 'staging':
        flavor = Flavor.staging;
        break;
      case 'production':
        flavor = Flavor.production;
        break;
      default:
        flavor = Flavor.develop;
        break;
    }

    // Mailjet
    mailjetApiKeyPrivate = _getVarFromKey('MAILJET_API_KEY_PRIVATE');
    mailjetApiKeyPublic = _getVarFromKey('MAILJET_API_KEY_PUBLIC');
    mailjetEmailSender = _getVarFromKey('MAILJET_EMAIL_SENDER');

    // Gemini
    geminiApiKey = _getVarFromKey('GEMINI_API_KEY');
  }

  String _getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }
}

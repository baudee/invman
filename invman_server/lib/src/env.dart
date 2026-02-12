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

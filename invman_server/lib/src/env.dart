import 'package:dotenv/dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

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
  late final int cacheDurationDays;

  final _log = Logger('Env');

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
    _log.info('App flavor: $flavor');

    // Mailjet
    mailjetApiKeyPrivate = _getVarFromKey('MAILJET_API_KEY_PRIVATE');
    mailjetApiKeyPublic = _getVarFromKey('MAILJET_API_KEY_PUBLIC');
    mailjetEmailSender = _getVarFromKey('MAILJET_EMAIL_SENDER');
    _log.info('Mailjet config loaded. Public key: $mailjetApiKeyPublic, sender: $mailjetEmailSender');
    

    // Gemini
    geminiApiKey = _getVarFromKey('GEMINI_API_KEY');

    // Config
    cacheDurationDays = _getIntVarFromKey('CACHE_DURATION_DAYS');
    _log.info('Config loaded. Cache duration (days): $cacheDurationDays');
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

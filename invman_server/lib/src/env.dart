import 'package:dotenv/dotenv.dart';

class Env {
  late final DotEnv env;
  late final String yfinBaseUrl;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    // Fast Finance Base URL
    yfinBaseUrl = getVarFromKey('YFIN_BASE_URL');
  }

  String getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }
}
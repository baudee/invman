import 'package:dotenv/dotenv.dart';

class Env {
  late final DotEnv env;
  late final String fmpApiKey;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    // FMP API KEY
    fmpApiKey = getVarFromKey('FMP_API_KEY');
  }

  String getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }
}
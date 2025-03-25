import 'package:dotenv/dotenv.dart';

class Env {
  late final DotEnv env;
  late final String twelvedataApiKey;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();
    if (env['TWELVEDATA_API_KEY'] == null) {
      throw Exception("TWELVEDATA_API_KEY not set in environment.");
    }
    twelvedataApiKey = env['TWELVEDATA_API_KEY']!;
  }
}
import 'package:dotenv/dotenv.dart';

class Env {
  late final DotEnv env;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();
    // if (env['GOOGLE_API_KEY'] == null) {
    //   throw Exception("GOOGLE_API_KEY not set in environment.");
    // }
    // googleApiKey = env['GOOGLE_API_KEY']!;
  }
}
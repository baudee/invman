import 'package:flutter/services.dart';

enum Flavor {
  develop,
  staging,
  production,
}

class Env {
  late final Flavor flavor;
  late final String baseUrl;

  Env() {
    switch (appFlavor) {
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

    const stringBaseUrl = String.fromEnvironment("BASE_URL");
    if (stringBaseUrl.isEmpty && flavor == Flavor.develop) {
      baseUrl = "http://localhost:8080/";
    } else if (stringBaseUrl.isEmpty) {
      throw Exception("BASE_URL is not set");
    } else {
      baseUrl = stringBaseUrl;
    }
  }
}

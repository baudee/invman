import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

enum Flavor { develop, staging, production }

@singleton
class Env {
  late final Flavor flavor;
  late final String baseUrl;
  late final String sentryDsn;

  Env() {
    switch (appFlavor) {
      case 'develop':
        flavor = Flavor.develop;
      case 'staging':
        flavor = Flavor.staging;
      case 'production':
        flavor = Flavor.production;
      default:
        flavor = Flavor.develop;
    }

    const stringBaseUrl = String.fromEnvironment("BASE_URL");
    if (stringBaseUrl.isEmpty && flavor == Flavor.develop) {
      baseUrl = "http://localhost:8080/";
    } else if (stringBaseUrl.isEmpty) {
      throw Exception("BASE_URL is not set");
    } else {
      baseUrl = stringBaseUrl;
    }

    const stringSentryDsn = String.fromEnvironment("SENTRY_DSN");
    if (stringSentryDsn.isEmpty && flavor != Flavor.develop) {
      throw Exception("SENTRY_DSN is not set for ${flavor.name} environment");
    } else {
      sentryDsn = stringSentryDsn;
    }
  }
}

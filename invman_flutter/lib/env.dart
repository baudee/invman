import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

enum Flavor { develop, staging, production }

@singleton
class Env {
  late final Flavor flavor;
  late final String baseUrl;
  late final String sentryDsn;
  late final String iosRevenueCatApiKey;
  late final String androidRevenueCatApiKey;

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

    const String stringSentryDsn = String.fromEnvironment("SENTRY_DSN");
    if (flavor != Flavor.develop) {
      sentryDsn = _checkIfEmpty("SENTRY_DSN", stringSentryDsn);
    } else {
      sentryDsn = "";
    }

    const String stringBaseUrl = String.fromEnvironment("BASE_URL");
    baseUrl = _checkIfEmpty("BASE_URL", stringBaseUrl);

    const String stringIosRevenueCatApiKey = String.fromEnvironment("IOS_REVENUE_CAT_API_KEY");
    iosRevenueCatApiKey = _checkIfEmpty("IOS_REVENUE_CAT_API_KEY", stringIosRevenueCatApiKey);

    const String stringAndroidRevenueCatApiKey = String.fromEnvironment("ANDROID_REVENUE_CAT_API_KEY");
    androidRevenueCatApiKey = _checkIfEmpty("ANDROID_REVENUE_CAT_API_KEY", stringAndroidRevenueCatApiKey);
  }

  String _checkIfEmpty(String key, String value) {
    if (value.isEmpty) {
      throw Exception("Environment variable $key not set.");
    }
    return value;
  }
}

enum Flavor {
  develop,
  staging,
  production,
}

class Env {
  static final Env _instance = Env._internal();

  late final Flavor flavor;
  late final String baseUrl;
  late final String sentryDsn;

  factory Env() {
    return _instance;
  }

  Env._internal() {
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

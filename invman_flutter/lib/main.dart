import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invman_flutter/app.dart';
import 'package:invman_flutter/di.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:invman_flutter/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DEPENDENCY INJECTION
  await configureDependencies();

  final env = getIt<Env>();
  if (env.sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = env.sentryDsn;
        options.environment = env.flavor.name;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () async {
        await _initializeApp(env);
      },
    );
  } else {
    await _initializeApp(env);
  }
}

Future<void> _initializeApp(Env env) async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await _initializeRevenueCat(env.androidRevenueCatApiKey, env.iosRevenueCatApiKey);

  runApp(const MyApp());
}

Future<void> _initializeRevenueCat(String androidApiKey, String iosApiKey) async {
  String apiKey;
  if (Platform.isIOS) {
    apiKey = iosApiKey;
  } else if (Platform.isAndroid) {
    apiKey = androidApiKey;
  } else {
    throw UnsupportedError('Platform not supported');
  }

  await Purchases.configure(PurchasesConfiguration(apiKey));
}

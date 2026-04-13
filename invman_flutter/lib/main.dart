import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invman_flutter/app.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/env.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  // Initialize app
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Start app
  final env = getIt<Env>();
  if (env.flavor == Flavor.develop) {
    runApp(const MyApp());
  } else {
    await SentryFlutter.init(
      (options) {
        options.dsn = env.sentryDsn;
        options.sendDefaultPii = true;
        options.environment = env.flavor.name;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(SentryWidget(child: MyApp())),
    );
  }
}

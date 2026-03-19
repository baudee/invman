import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/config/theme/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:invman_flutter/env.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() async {
  // DEPENDENCY INJECTION
  await configureDependencies();

  final env = getIt<Env>();
  if (env.sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = env.sentryDsn;
        options.environment = env.flavor.name;
        // Set tracesSampleRate to 1.0 to capture 100% of the transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
      },
      appRunner: () async {
        await _initializeApp();
      },
    );
  } else {
    await _initializeApp();
  }
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.light().themeData,
      darkTheme: AppTheme.dark().themeData,
      themeMode: getIt<UserPreferencesManager>().theme.watch(context),
      locale: getIt<UserPreferencesManager>().locale.watch(context),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SupportedLanguage.values.map((e) => Locale.fromSubtags(languageCode: e.languageCode)).toList(),
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<GoRouter>(),
    );
  }
}

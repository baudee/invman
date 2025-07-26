import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/theme/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:invman_flutter/env.dart';

late final SharedPreferences prefs;

void main() async {
  final env = Env();
  
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

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  prefs = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booting = ref.watch(bootstrapProvider);

    final appName = "InvMan";

    if (booting) {
      return MaterialApp(
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: LoadingComponent(),
        ),
      );
    }

    router = ref.read(appRouterProvider);

    return MaterialApp.router(
      title: appName,
      theme: AppTheme.light().themeData,
      darkTheme: AppTheme.dark().themeData,
      themeMode: ref.watch(userPreferencesProvider.select((value) => value.theme)),
      locale: ref.watch(userPreferencesProvider.select((value) => value.locale)),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SupportedLanguage.values.map((e) => Locale.fromSubtags(languageCode: e.languageCode)).toList(),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

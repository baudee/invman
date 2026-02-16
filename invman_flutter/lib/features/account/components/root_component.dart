import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AccountRootComponent extends HookWidget {
  const AccountRootComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefsManager = useMemoized(() => getIt<UserPreferencesManager>());
    final currentLocale = userPrefsManager.locale.watch(context);
    final currentTheme = userPrefsManager.theme.watch(context);

    final authManager = useMemoized(() => getIt<AuthManager>());

    final tiles = [
      ListTile(
        title: Text(S.of(context).account_language),
        subtitle: Text(currentLocale.toLanguageTag()),
        leading: Icon(Icons.language),
        trailing: DropdownButton<Locale>(
          value: currentLocale,
          onChanged: (value) {
            if (value != null) {
              userPrefsManager.setLocale(value);
            }
          },
          items: [
            ...SupportedLanguage.values.map(
              (e) => DropdownMenuItem(
                value: Locale.fromSubtags(languageCode: e.languageCode),
                child: Text(S.of(context).core_language(e.languageName)),
              ),
            ),
          ],
        ),
      ),
      ListTile(
        title: Text(S.of(context).account_theme),
        subtitle: Text(S.of(context).core_theme(currentTheme.name)),
        leading: Icon(Icons.color_lens),
        trailing: DropdownButton<ThemeMode>(
          value: currentTheme,
          onChanged: (value) {
            if (value != null) {
              userPrefsManager.setTheme(value);
            }
          },
          items: [
            ...ThemeMode.values.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(S.of(context).core_theme(e.name)),
              ),
            ),
          ],
        ),
      ),
      ListTile(
        title: Text(S.of(context).withdrawal_title),
        leading: Icon(Icons.list_alt_rounded),
        onTap: () => router.pushRelative(WithdrawalRuleRootScreen.route()),
      ),
      ListTile(
        title: Text(S.of(context).account_currency),
        subtitle: Text(authManager.currencyCode),
        leading: Icon(Icons.attach_money_rounded),
      ),
      ListTile(
        title: Text(
          S.of(context).auth_logOut,
          style: TextStyle(color: Colors.red),
        ),
        leading: Icon(Icons.logout, color: Colors.red),
        onTap: () async {
          final errorMessage = await authManager.logout();

          if (errorMessage == null && context.mounted) {
            StatefulNavigationShell.of(
              context,
            ).goBranch(0, initialLocation: true);
          } else {
            ToastUtils.message(errorMessage, success: false);
          }
        },
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: tiles
            .map(
              (tile) => Padding(
                padding: const EdgeInsets.only(bottom: UIConstants.spacingXs),
                child: tile,
              ),
            )
            .toList(),
      ),
    );
  }
}

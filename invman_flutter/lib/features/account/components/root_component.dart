import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:invman_flutter/main.dart';

class AccountRootComponent extends ConsumerWidget {
  const AccountRootComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(S.of(context).account_language),
            subtitle: Text(ref.watch(userPreferencesProvider.select((v) => v.locale)).toLanguageTag()),
            leading: Icon(Icons.language),
            trailing: DropdownButton<Locale>(
              value: ref.watch(userPreferencesProvider.select((v) => v.locale)),
              onChanged: (value) {
                if (value != null) {
                  ref.read(userPreferencesProvider.notifier).setLocale(value);
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
            subtitle: Text(S.of(context).core_theme(ref.watch(userPreferencesProvider.select((v) => v.theme)).name)),
            leading: Icon(Icons.color_lens),
            trailing: DropdownButton<ThemeMode>(
              value: ref.watch(userPreferencesProvider.select((v) => v.theme)),
              onChanged: (value) {
                if (value != null) {
                  ref.read(userPreferencesProvider.notifier).setTheme(value);
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
            subtitle: Text(ref.read(userPreferencesProvider).currency),
            leading: Icon(Icons.attach_money_rounded),
          ),
          ListTile(
            title: Text(
              S.of(context).auth_logOut,
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: () async {
              final errorMessage = await ref.read(authProvider.notifier).logout();

              if (errorMessage == null && context.mounted) {
                StatefulNavigationShell.of(context).goBranch(0, initialLocation: true);
              } else {
                ToastUtils.message(errorMessage, success: false);
              }
            },
          ),
        ],
      ),
    );
  }
}

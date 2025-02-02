import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/generated/l10n.dart';

class AccountComponent extends ConsumerWidget {
  const AccountComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(S.of(context).language),
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
                    child: Text(e.languageName),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(S.of(context).theme),
            subtitle: Text(ref.watch(userPreferencesProvider.select((v) => v.theme)).label),
            leading: Icon(Icons.color_lens),
            trailing: DropdownButton<AppThemeEnum>(
              value: ref.watch(userPreferencesProvider.select((v) => v.theme)),
              onChanged: (value) {
                if (value != null) {
                  ref.read(userPreferencesProvider.notifier).setTheme(value);
                }
              },
              items: [
                ...AppThemeEnum.values.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.label),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              S.of(context).logOut,
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: () async {
              await ref.read(authProvider.notifier).logout();

              if (context.mounted) {
                StatefulNavigationShell.of(context).goBranch(0, initialLocation: true);
              }
            },
          ),
        ],
      ),
    );
  }
}

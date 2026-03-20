import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AccountRootComponent extends StatelessWidget {
  final AccountController controller;

  const AccountRootComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final userPrefsManager = getIt<UserPreferencesManager>();
    final currentLocale = userPrefsManager.locale.watch(context);
    final currentTheme = userPrefsManager.theme.watch(context);

    final authManager = getIt<AuthManager>();

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
            ...ThemeMode.values.map((e) => DropdownMenuItem(value: e, child: Text(S.of(context).core_theme(e.name)))),
          ],
        ),
      ),
      ListTile(
        title: Text(S.of(context).withdrawal_title),
        leading: Icon(Icons.list_alt_rounded),
        onTap: () => router.push(WithdrawalRuleRootScreen.route()),
      ),
      _buildCurrencyTile(context, authManager),
      ListTile(
        title: Text(S.of(context).auth_logOut, style: TextStyle(color: Colors.red)),
        leading: Icon(Icons.logout, color: Colors.red),
        onTap: () async {
          final errorMessage = await authManager.logout();

          if (errorMessage == null && context.mounted) {
            StatefulNavigationShell.of(context).goBranch(0, initialLocation: true);
          } else {
            ToastUtils.message(errorMessage, success: false);
          }
        },
      ),
    ];

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
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

  ListTile _buildCurrencyTile(BuildContext context, AuthManager authManager) {
    return ListTile(
      title: Text(S.of(context).account_currency),
      subtitle: Text(authManager.account.watch(context)?.currency?.code ?? "-"),
      leading: Icon(Icons.attach_money_rounded),
      trailing: controller.state
          .watch(context)
          .map(
            data: (currencies) {
              if (controller.selectedCurrency.watch(context) == null) {
                return CircularProgressIndicator();
              }
              return DropdownButton<Currency>(
                value: controller.selectedCurrency.watch(context),
                onChanged: (value) {
                  if (value != null) {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(S.of(context).account_change_currency),
                          content: Text(S.of(context).account_change_currency_description),
                          actions: <Widget>[
                            FilledButton(child: Text(S.of(context).core_cancel), onPressed: () => context.pop()),
                            TextButton(
                              child: Text(S.of(context).core_apply),
                              onPressed: () async {
                                context.pop();
                                final error = await controller.changeCurrency(value);
                                if (error != null) {
                                  ToastUtils.message(error, success: false);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                items: currencies
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.code),
                      ),
                    )
                    .toList(),
              );
            },
            error: (_) => null,
            loading: () => CircularProgressIndicator(),
          ),
    );
  }
}

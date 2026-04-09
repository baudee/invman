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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AccountRootComponent extends StatelessWidget {
  final AccountController controller;

  const AccountRootComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final userPrefsManager = getIt<UserPreferencesManager>();
    final authManager = getIt<AuthManager>();
    final packageInfoModule = getIt<PackageInfo>();

    final currentLocale = userPrefsManager.locale.watch(context);
    final currentTheme = userPrefsManager.theme.watch(context);

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
      PlanGuard(
        requiredPlan: AccountPlan.pro,
        child: ListTile(
          title: Text(S.of(context).account_exportTransfers),
          subtitle: Text(S.of(context).account_exportTransfersSubtitle),
          leading: Icon(Icons.download_rounded),
          onTap: () => _onExport(context),
        ),
      ),
      PlanGuard(
        requiredPlan: AccountPlan.pro,
        child: ListTile(
          title: Text(S.of(context).account_importTransfers),
          subtitle: Text(S.of(context).account_importTransfersSubtitle),
          leading: Icon(Icons.upload_rounded),
          trailing: IconButton(
            icon: Icon(Icons.description_outlined),
            tooltip: S.of(context).account_downloadTemplate,
            onPressed: () => controller.shareTemplate(),
          ),
          onTap: () => _onImport(context),
        ),
      ),
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
      Text(packageInfoModule.version, style: Theme.of(context).textTheme.bodySmall),
    ];

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: tiles
            .map(
              (tile) => Padding(
                padding: const EdgeInsets.only(bottom: UIConstants.spacingXs),
                child: Material(child: tile),
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _onExport(BuildContext context) async {
    final error = await controller.exportCsv();
    if (error != null && context.mounted) {
      ToastUtils.message(error, success: false);
    }
  }

  Future<void> _onImport(BuildContext context) async {
    final result = await controller.importCsv();
    if (!context.mounted) return;

    if (result.cancelled) return;

    if (result.error != null) {
      ToastUtils.message(result.error!, success: false);
    } else if (result.validationErrors.isEmpty) {
      ToastUtils.message(S.of(context).account_importSuccess);
    } else {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(S.of(context).account_importErrors),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).account_importErrorsDescription),
                const SizedBox(height: 12),
                ...result.validationErrors.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $e', style: const TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => ctx.pop(),
              child: Text(S.of(context).core_cancel),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCurrencyTile(BuildContext context, AuthManager authManager) {
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

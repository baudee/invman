import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/app_settings/app_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateRequiredScreen extends HookWidget {
  const UpdateRequiredScreen({super.key});

  static String route() => '/update-required';

  Future<void> _openStore() async {
    final storeUrl = getIt<AppSettingsManager>().storeUrl.value;
    if (storeUrl == null) return;

    final uri = Uri.parse(storeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeUrl = getIt<AppSettingsManager>().storeUrl.value;

    return BaseScreen(
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Icon(Icons.system_update_rounded, size: 80, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: UIConstants.spacingXl),
          Text(
            S.of(context).appSettings_updateTitle,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: .center,
          ),
          const SizedBox(height: UIConstants.spacingMd),
          Text(
            S.of(context).appSettings_updateSubtitle,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: .center,
          ),
          if (storeUrl != null) ...[
            const SizedBox(height: UIConstants.spacingXxl),
            FilledButton.icon(
              onPressed: _openStore,
              icon: const Icon(Icons.download_rounded),
              label: Text(S.of(context).appSettings_updateButton),
            ),
          ],
        ],
      ),
    );
  }
}

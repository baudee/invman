import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  static String route() => '/maintenance';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Icon(Icons.build_rounded, size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: UIConstants.spacingXxl),
            Text(
              S.of(context).appSettings_maintenanceTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: UIConstants.spacingMd),
            Text(
              S.of(context).appSettings_maintenanceSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

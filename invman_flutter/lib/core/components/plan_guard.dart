import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PlanGuard extends StatelessWidget {
  final AccountPlan requiredPlan;
  final Widget child;

  const PlanGuard({
    super.key,
    required this.requiredPlan,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();

    final hasAccess = AccountPlan.values.indexOf(authManager.plan) >= AccountPlan.values.indexOf(requiredPlan);
    if (hasAccess) return child;

    return Stack(
      children: [
        AbsorbPointer(child: Opacity(opacity: 0.5, child: child)),
        Positioned.fill(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {
              await RevenueCatUI.presentPaywallIfNeeded('premium');
              await authManager.refreshMe();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 50,
                  child: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/images/logo.webp")),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

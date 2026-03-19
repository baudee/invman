import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/constants/ui_constants.dart';
import 'package:invman_flutter/core/utils/ui_utils/toast_utils.dart';
import 'package:invman_flutter/features/onboarding/onboarding.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OnboardingRootComponent extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingRootComponent({super.key, required this.controller});

  static String route() => OnboardingRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).onboarding_welcome, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: UIConstants.spacingMd),
        Text(S.of(context).onboarding_select_currency, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: UIConstants.spacingLg),
        DropdownMenu(
          dropdownMenuEntries: controller.state.watch(context).requireValue
              .map((c) => DropdownMenuEntry(value: c.id, label: c.code))
              .toList(),
          onSelected: (value) => controller.selectCurrency(value),
        ),
        const Spacer(),
        controller.isValidating.watch(context)
            ? const LoadingComponent()
            : ActionButton(
                onPressed: controller.selectedCurrency.watch(context) != null
                    ? () async {
                        final result = await controller.validateCurrency();
                        if (result != null) {
                          ToastUtils.message(result, success: false);
                        }
                      }
                    : null,
                child: Text(S.of(context).core_continue),
              ),
      ],
    );
  }
}

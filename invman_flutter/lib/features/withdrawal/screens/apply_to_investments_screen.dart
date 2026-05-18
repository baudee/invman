import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:signals_flutter/signals_flutter.dart';

class WithdrawalRuleApplyToInvestmentsScreen extends HookWidget {
  final int ruleId;
  const WithdrawalRuleApplyToInvestmentsScreen({super.key, required this.ruleId});

  static const pathSegment = 'apply';
  static String route(int ruleId) => '${WithdrawalRoutes.namespace}/$ruleId/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<WithdrawalRuleApplyController>(param1: ruleId));

    return BaseScreen(
      appBar: AppBar(
        title: Text(S.of(context).withdrawal_applyToInvestments),
        actions: [
          Watch(
            (_) => controller.isApplying.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: UIConstants.spacingMd),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.check),
                    tooltip: S.of(context).core_save,
                    onPressed: () async {
                      final (success, error) = await controller.apply();
                      if (success) {
                        ToastUtils.message(S.of(context).withdrawal_applyToInvestments_success, success: true);
                        router.pop();
                      } else {
                        ToastUtils.message(error ?? '', success: false);
                      }
                    },
                  ),
          ),
        ],
      ),
      body: InfiniteListComponent(
        controller: controller,
        itemBuilder: (investment) => Watch(
          (_) => InvestmentSelectTileComponent(
            investment: investment,
            selected: controller.selectedIds.value.contains(investment.id),
            locked: controller.isLocked(investment),
            onToggle: () => controller.toggle(investment.id!),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/controllers/count_manager.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/asset/asset.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InvestmentFormComponent extends StatelessWidget {
  final InvestmentEditController controller;
  const InvestmentFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final investment = controller.state.watch(context).requireValue;
    final shouldNotPopAfterSave = controller.id == 0 && investment.assetId != UuidValue.fromString(Namespace.nil.value);
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller.nameController,
            validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).core_name),
            decoration: InputDecoration(label: Text(S.of(context).core_name)),
          ),
          SizedBox(height: UIConstants.spacingSm),
          SectionHeaderComponent(title: S.of(context).withdrawal_selection),
          SizedBox(height: UIConstants.spacingXs),
          WithdrawalRuleSelectTileComponent(
            rule: investment.withdrawalRule,
            onRuleSelected: controller.setWithdrawalRule,
          ),
          SizedBox(height: UIConstants.spacingXs),
          SectionHeaderComponent(title: S.of(context).asset_selection),
          SizedBox(height: UIConstants.spacingXs),
          AssetSelectTileComponent(asset: investment.asset, onAssetSelected: controller.setAsset),
          Spacer(),
          Builder(
            builder: (context) {
              final saveButton = SaveButton(
                onPressed: () async {
                  final (success, message) = await controller.submit();
                  if (success) {
                    final id = controller.state.value.requireValue.id!;
                    if (shouldNotPopAfterSave) {
                      // From Asset detail page
                      router.pushReplacement(InvestmentDetailScreen.route(id));
                    } else {
                      // From Investment list page
                      router.pop();
                    }
                  } else {
                    ToastUtils.message(message, success: success);
                  }
                },
              );
              if (getIt<AuthManager>().plan == AccountPlan.free) {
                final count = getIt<InvestmentCountManager>().count.watch(context);
                if (count != null && count >= freeInvestmentLimit) {
                  return PlanGuard(
                    requiredPlan: AccountPlan.pro,
                    child: saveButton,
                  );
                }
              }
              return saveButton;
            },
          ),
          SizedBox(height: UIConstants.spacingSm),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeEditScreen extends HookWidget {
  final int ruleId;
  final int id;
  const WithdrawalFeeEditScreen({
    super.key,
    required this.ruleId,
    required this.id,
  });

  static String route([int? id]) =>
      id == null ? "/edit" : "${WithdrawalRoutes.namespaceFee}/$id/edit";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => getIt<WithdrawalFeeEditController>(param1: ruleId, param2: id),
    );
    return BaseScreen(
      appBar: AppBar(
        title: Text(
          id == 0
              ? S.of(context).withdrawal_fee_create
              : S.of(context).withdrawal_fee_edit,
        ),
      ),
      body: BaseStateComponent(
        state: controller,
        successBuilder: (_) =>
            WithdrawalFeeFormComponent(controller: controller),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleEditScreen extends HookWidget {
  final int id;
  const WithdrawalRuleEditScreen({super.key, required this.id});
  static const pathSegment = 'edit';
  static String route(int id) => '${WithdrawalRoutes.namespace}/$id/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<WithdrawalRuleEditController>(param1: id));
    return BaseScreen(
      appBar: AppBar(title: Text(id == 0 ? S.of(context).withdrawal_create : S.of(context).withdrawal_edit)),
      body: BaseStateComponent(
        state: controller.state,
        onReload: controller.reload,
        successBuilder: (_) => WithdrawalRuleFormComponent(controller: controller),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleDetailScreen extends HookWidget {
  final int id;
  const WithdrawalRuleDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<WithdrawalRuleDetailController>(param1: id));
    return BaseScreen(
      appBar: BaseStateAppbar(
        state: controller.state,
        successBuilder: (w) => AppBar(
          title: Text(w.name),
          actions: [
            PopupMenuActions(
              onEdit: () async {
                await router.pushRelative(WithdrawalRuleEditScreen.route());
                controller.reload();
              },
              onDelete: () async {
                final (success, message) = await controller.delete();
                router.pop();
                ToastUtils.message(message, success: success);
              },
            ),
          ],
        ),
      ),
      body: BaseStateComponent(
        state: controller.state,
        onReload: controller.reload,
        successBuilder: (rule) => WithdrawalRuleDetailComponent(rule: rule),
      ),
    );
  }
}

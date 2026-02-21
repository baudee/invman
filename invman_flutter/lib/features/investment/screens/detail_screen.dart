import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentDetailScreen extends HookWidget {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<InvestmentDetailController>(param1: id));
    return BaseScreen(
      appBar: BaseStateAppbar<Investment>(
        state: controller,
        successBuilder: (investment) => AppBar(
          title: Text(investment.name),
          actions: [
            PopupMenuActions(
              onEdit: () async {
                await router.pushRelative(InvestmentEditScreen.route());
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
        state: controller,
        successBuilder: (investment) => InvestmentDetailComponent(investment: investment),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentEditScreen extends HookWidget {
  final int id;
  final Stock? stock;
  const InvestmentEditScreen({super.key, required this.id, this.stock});

  static const pathSegment = 'edit';
  static String route(int id) => '${InvestmentRoutes.namespace}/$id/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<InvestmentEditController>(param1: id), [id]);
    if (stock != null) {
      controller.setStock(stock!);
    }
    return BaseScreen(
      appBar: AppBar(title: Text(id == 0 ? S.of(context).investment_create : S.of(context).investment_edit)),
      body: BaseStateComponent(
        state: controller.state,
        onReload: controller.reload,
        successBuilder: (_) => InvestmentFormComponent(controller: controller),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentEditScreen extends HookWidget {
  final int id;
  const InvestmentEditScreen({super.key, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "/$id/edit";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => getIt<InvestmentEditController>(param1: id),
    );
    return BaseScreen(
      appBar: AppBar(
        title: Text(
          id == 0
              ? S.of(context).investment_create
              : S.of(context).investment_edit,
        ),
      ),
      body: BaseStateComponent(
        state: controller,
        successBuilder: (_) => InvestmentFormComponent(controller: controller),
      ),
    );
  }
}

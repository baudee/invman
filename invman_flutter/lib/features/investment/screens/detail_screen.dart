import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentDetailScreen extends BaseScreen {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  AppBar? appBar(BuildContext context) {
    final controller = getIt<InvestmentDetailController>(param1: id);
    return controller.value.map(
      data: (investment) => AppBar(
        title: Text(investment.name),
        actions: [EditIconButton(onPressed: () => getIt<GoRouter>().pushRelative(InvestmentEditScreen.route()))],
      ),
      error: (_, _) => AppBar(
        actions: [EditIconButton(onPressed: () => getIt<GoRouter>().pushRelative(InvestmentEditScreen.route()))],
      ),
      loading: () => AppBar(
        actions: [EditIconButton(onPressed: () => getIt<GoRouter>().pushRelative(InvestmentEditScreen.route()))],
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return BaseStateComponent<Investment>(
      state: getIt<InvestmentDetailController>(param1: id),
      successBuilder: (investment) => InvestmentDetailComponent(investment: investment),
    );
  }
}

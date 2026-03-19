import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentDetailScreen extends HookWidget {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static const pathSegment = ':id';
  static String route(int id) => '${InvestmentRoutes.namespace}/$id';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<InvestmentDetailController>(param1: id), [id]);
    final authManager = getIt<AuthManager>();
    return Scaffold(
      body: BaseStateComponent(
        state: controller.state,
        onReload: controller.reload,
        successBuilder: (_) => InvestmentDetailComponent(controller: controller, authManager: authManager),
      ),
    );
  }
}

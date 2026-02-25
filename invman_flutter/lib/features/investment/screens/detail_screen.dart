import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentDetailScreen extends HookWidget {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<InvestmentDetailController>(param1: id));
    final authManager = useMemoized(() => getIt<AuthManager>());
    return Scaffold(
      body: BaseStateComponent(
        state: controller,
        successBuilder: (investment) =>
            InvestmentDetailComponent(investment: investment, controller: controller, authManager: authManager),
      ),
    );
  }
}

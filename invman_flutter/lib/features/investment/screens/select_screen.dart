import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentSelectScreen extends ConsumerWidget {
  const InvestmentSelectScreen({super.key});

  static String route() => "${InvestmentRoutes.namespace}/select";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(child: InvestmentListComponent()),
    );
  }
}

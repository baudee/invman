import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentSliverHeaderComponent extends StatelessWidget {
  final Investment invesment;

  const InvestmentSliverHeaderComponent({super.key, required this.invesment});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InvestmentHeaderComponent(investment: invesment),
    );
  }
}

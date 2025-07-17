import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentHeaderComponent extends StatelessWidget {
  final Investment investment;

  const InvestmentHeaderComponent({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(investment.name),
        Text(investment.investAmount?.toStringAsFixed(2) ?? '-'),
        Text(investment.withdrawAmount?.toStringAsFixed(2) ?? '-'),
        Text(
          "${investment.percent.toStringAsFixed(2)}%",
          style: TextStyle(color: investment.percentColor),
        )
      ],
    );
  }
}

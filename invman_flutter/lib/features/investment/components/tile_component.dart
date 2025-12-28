import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router/router.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentTileComponent extends ConsumerWidget {
  final Investment investment;

  const InvestmentTileComponent({super.key, required this.investment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    return ListTile(
      title: Text(investment.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        "${investment.investAmount.toStringPrice(currency)} / ${investment.withdrawAmount?.toStringPrice(currency)}",
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end, 
        children: [
          Text(
            "${investment.percent.toStringAsFixed(1)}%",
            style: TextStyle(
              color: investment.percentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(investment.amountDifference.toStringPrice(currency), style: TextStyle(color: investment.percentColor)),
        ],
      ),
      onTap: () => router.pushRelative(InvestmentDetailScreen.route(investment.id)),
    );
  }
}

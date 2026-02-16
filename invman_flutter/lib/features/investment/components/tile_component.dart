import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentTileComponent extends HookWidget {
  final Investment investment;

  const InvestmentTileComponent({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    final authManager = useMemoized(() => getIt<AuthManager>());
    return ListTile(
      title: Text(investment.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        "${investment.investAmount.toStringPrice(authManager.currencyCode)} / ${investment.withdrawAmount?.toStringPrice(authManager.currencyCode)}",
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
          Text(
            investment.amountDifference.toStringPrice(authManager.currencyCode),
            style: TextStyle(color: investment.percentColor),
          ),
        ],
      ),
      onTap: () =>
          router.pushRelative(InvestmentDetailScreen.route(investment.id)),
    );
  }
}

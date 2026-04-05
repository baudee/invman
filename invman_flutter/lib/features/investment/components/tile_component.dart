import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentTileComponent extends StatelessWidget {
  final Investment investment;

  const InvestmentTileComponent({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();
    return ListTile(
      leading: investment.asset != null ? AvatarComponent(asset: investment.asset!) : null,
      title: Text(investment.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(investment.asset?.name ?? "", overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${investment.returnPercentage?.toStringAsFixed(1)}%",
            style: TextStyle(color: investment.percentColor, fontWeight: FontWeight.bold),
          ),
          Text(
            investment.totalProfit.toStringPrice(authManager.currencyCode),
            style: TextStyle(color: _getColor(investment.totalProfit)),
          ),
        ],
      ),
      onTap: () => router.push(InvestmentDetailScreen.route(investment.id!)),
    );
  }

  Color? _getColor(double? value) {
    if (value == null) return null;
    if (value > 0) return Colors.green;
    if (value < 0) return Colors.red;
    return null;
  }
}

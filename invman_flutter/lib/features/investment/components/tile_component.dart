import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/models/investment_ext.dart';

class InvestmentTileComponent extends ConsumerWidget {
  final Investment investment;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final Function(Investment investment)? onTap;

  const InvestmentTileComponent({super.key, required this.investment, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    return ListTile(
      contentPadding: contentPadding,
      title: Text(investment.stock.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
          "${investment.investAmount.toStringPrice(currency)} / ${investment.withdrawAmount.toStringPrice(currency)}"),
      trailing: trailing ??
          Text(
            "${investment.percent.toStringAsFixed(2)}%",
            style: TextStyle(color: investment.percentColor),
          ),
      onTap: () {
        if (onTap != null) {
          onTap!(investment);
        }
      },
    );
  }
}

class StockTileComponent extends ConsumerWidget {
  final Stock stock;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final Function(Stock stock)? onTap;

  const StockTileComponent({super.key, required this.stock, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: contentPadding,
      title: Text(stock.name, overflow: TextOverflow.ellipsis),
      subtitle: Text("${stock.symbol} - ${stock.quoteType} - ${stock.value} ${stock.currency}"),
      trailing: trailing,
      onTap: () {
        if (onTap != null) {
          onTap!(stock);
        }
      },
    );
  }
}

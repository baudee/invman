import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailComponent extends StatelessWidget {
  final Stock stock;
  const StockDetailComponent({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          StockHeaderComponent(stock: stock),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: UIConstants.appHorizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: UIConstants.spacingXl),
                  SectionHeaderComponent(title: S.of(context).stock_info),
                  const SizedBox(height: UIConstants.spacingSm),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Theme.of(context).colorScheme.primary),
                    title: Text(S.of(context).investment_currency),
                    trailing: Text(stock.currency?.code ?? '-'),
                  ),
                  const SizedBox(height: UIConstants.spacingSm),
                  ListTile(
                    leading: Icon(Icons.category, color: Theme.of(context).colorScheme.primary),
                    title: Text(S.of(context).investment_quoteType),
                    trailing: Text(S.of(context).stock_type(stock.quoteType.name)),
                  ),
                  const SizedBox(height: UIConstants.spacingSm),
                  ListTile(
                    leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                    title: Text(S.of(context).core_lastUpdate),
                    trailing: Text(DateFormat.yMMMd().add_jm().format(stock.updatedAt.toLocal())),
                  ),
                  const Spacer(),
                  ActionButton(
                    child: Text(S.of(context).investment_create),
                    onPressed: () => router.push(InvestmentEditScreen.absoluteRoute(0), extra: stock),
                  ),
                  const SizedBox(height: UIConstants.spacingMd),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

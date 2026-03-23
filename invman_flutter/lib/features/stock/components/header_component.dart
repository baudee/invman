import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/stock/components/components.dart';

class StockHeaderComponent extends StatelessWidget {
  final Stock stock;
  const StockHeaderComponent({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: kToolbarHeight * 2,
        left: UIConstants.spacingXxl,
        right: UIConstants.spacingXxl,
        bottom: UIConstants.spacingXxl * 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primaryContainer, theme.scaffoldBackgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          AvatarComponent(stock: stock, size: MediaQuery.of(context).size.width * 0.2),
          const SizedBox(width: UIConstants.spacingXxl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stock.symbol, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
              const SizedBox(height: UIConstants.spacingSm),
              Text(
                stock.price.toStringPrice(stock.currency?.code),
                style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: UIConstants.spacingSm),
              Text(stock.name, style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

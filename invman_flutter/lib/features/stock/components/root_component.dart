import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRootComponent extends StatelessWidget {
  final StockRootController controller;
  const StockRootComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UIConstants.spacingMd),
        StockSearchPlaceholderComponent(onTap: () => router.push(StockSearchScreen.route())),
        const SizedBox(height: UIConstants.spacingXxl),
        SectionHeaderComponent(
          title: S.of(context).stock_popular,
          onSeeAll: () => router.push(PopularStocksScreen.route()),
        ),
        BaseStateComponent(
          state: controller.popularStocks,
          onReload: controller.reload,
          successBuilder: (populars) => HorizontalListComponent<Stock>(
            items: populars,
            height: 120,
            itemBuilder: (stock) =>
                StockCardComponent(stock: stock, onTap: () => router.push(StockDetailScreen.route(stock.id))),
          ),
        ),
        BaseStateComponent(
          state: controller.likedStocks,
          onReload: controller.reload,
          successBuilder: (liked) => liked.isNotEmpty
              ? Column(
                  children: [
                    const SizedBox(height: UIConstants.spacingXxl),
                    SectionHeaderComponent(
                      title: S.of(context).stock_liked,
                      onSeeAll: () => router.push(LikedStocksScreen.route()),
                    ),
                    HorizontalListComponent<Stock>(
                      items: liked,
                      height: 120,
                      itemBuilder: (stock) =>
                          StockCardComponent(stock: stock, onTap: () => router.push(StockDetailScreen.route(stock.id))),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

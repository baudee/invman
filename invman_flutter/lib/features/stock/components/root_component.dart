import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
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
        StockSearchPlaceholderComponent(onTap: () => context.push(StockSearchScreen.route())),
        BaseStateComponent(
          state: controller.likedStocks,
          onReload: controller.fetchLikedStocks,
          successBuilder: (likedStocks) => likedStocks.isNotEmpty
              ? Column(
                  children: [
                    const SizedBox(height: UIConstants.spacingXxl),
                    SectionHeaderComponent(
                      title: S.of(context).stock_liked,
                      onSeeAll: () => context.push(LikedStocksScreen.route()),
                    ),
                    HorizontalListComponent<Stock>(
                      items: likedStocks,
                      height: 120,
                      itemBuilder: (stock) => StockCardComponent(
                        stock: stock,
                        onTap: () => context.push(StockDetailScreen.route(stock.id)),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        SectionHeaderComponent(
          title: S.of(context).stock_popular,
          onSeeAll: () => context.push(PopularStocksScreen.route()),
        ),
        BaseStateComponent(
          state: controller.popularStocks,
          onReload: controller.fetchPopularStocks,
          successBuilder: (populars) => HorizontalListComponent<Stock>(
            items: populars,
            height: 120,
            itemBuilder: (stock) =>
                StockCardComponent(stock: stock, onTap: () => context.push(StockDetailScreen.route(stock.id))),
          ),
        ),
      ],
    );
  }
}

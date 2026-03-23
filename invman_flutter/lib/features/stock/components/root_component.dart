import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/stock/stock.dart';
import 'package:signals_flutter/signals_flutter.dart';

class StockRootComponent extends StatelessWidget {
  final StockRootController controller;
  const StockRootComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: UIConstants.spacingMd),
          StockSearchPlaceholderComponent(onTap: () => router.push(StockSearchScreen.route())),
          BaseStateComponent(
            state: controller.likedStocks,
            onReload: controller.fetchLikedStocks,
            successBuilder: (likedStocks) => likedStocks.isNotEmpty
                ? Column(
                    children: [
                      SectionHeaderComponent(
                        title: S.of(context).stock_liked,
                        onSeeAll: () => router.push(LikedStocksScreen.route()),
                      ),
                      HorizontalListComponent<Stock>(
                        items: likedStocks,
                        height: 120,
                        itemBuilder: (stock) => StockCardComponent(
                          stock: stock,
                          onTap: () => router.push(StockDetailScreen.route(stock.id)),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          ..._buildPopularList(context, StockType.stock, controller.popularStocks, controller.fetchPopularStocks),
          ..._buildPopularList(context, StockType.crypto, controller.popularCryptos, controller.fetchPopularCryptos),
          ..._buildPopularList(context, StockType.etf, controller.popularETFs, controller.fetchPopularETFs),
          ..._buildPopularList(context, StockType.indice, controller.popularIndices, controller.fetchPopularIndices),
          ..._buildPopularList(
            context,
            StockType.commodity,
            controller.popularCommodities,
            controller.fetchPopularCommodities,
          ),
          const SizedBox(height: UIConstants.spacingSm),
        ],
      ),
    );
  }

  List<Widget> _buildPopularList(
    BuildContext context,
    StockType type,
    ReadonlySignal<AsyncState<List<Stock>>> state,
    Function onReload,
  ) {
    return [
      SectionHeaderComponent(
        title: "${S.of(context).core_popular} ${S.of(context).stock_type_plural(type)}",
        onSeeAll: () => router.push(PopularStocksScreen.route(), extra: type),
      ),
      BaseStateComponent(
        state: state,
        onReload: onReload,
        successBuilder: (populars) => HorizontalListComponent<Stock>(
          items: populars,
          height: 120,
          itemBuilder: (stock) =>
              StockCardComponent(stock: stock, onTap: () => router.push(StockDetailScreen.route(stock.id))),
        ),
      ),
    ];
  }
}

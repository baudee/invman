import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/asset.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AssetRootComponent extends StatelessWidget {
  final AssetRootController controller;
  const AssetRootComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: UIConstants.spacingMd),
          AssetSearchPlaceholderComponent(onTap: () => router.push(AssetSearchScreen.route())),
          BaseStateComponent(
            state: controller.likedAssets,
            onReload: controller.fetchLikedAssets,
            successBuilder: (likedAssets) => likedAssets.isNotEmpty
                ? Column(
                    children: [
                      SectionHeaderComponent(
                        title: S.of(context).asset_liked,
                        onSeeAll: () => router.push(LikedAssetsScreen.route()),
                      ),
                      HorizontalListComponent<Asset>(
                        items: likedAssets,
                        height: 120,
                        itemBuilder: (asset) => AssetCardComponent(
                          asset: asset,
                          onTap: () => router.push(AssetDetailScreen.route(asset.id)),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          ..._buildPopularList(context, AssetType.stock, controller.popularAssets, controller.fetchPopularAssets),
          ..._buildPopularList(context, AssetType.crypto, controller.popularCryptos, controller.fetchPopularCryptos),
          ..._buildPopularList(context, AssetType.etf, controller.popularETFs, controller.fetchPopularETFs),
          ..._buildPopularList(
            context,
            AssetType.commodity,
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
    AssetType type,
    ReadonlySignal<AsyncState<List<Asset>>> state,
    Function onReload,
  ) {
    return [
      SectionHeaderComponent(
        title: "${S.of(context).core_popular} ${S.of(context).asset_type_plural(type)}",
        onSeeAll: () => router.push(PopularAssetsScreen.route(), extra: type),
      ),
      BaseStateComponent(
        state: state,
        onReload: onReload,
        successBuilder: (populars) => HorizontalListComponent<Asset>(
          items: populars,
          height: 120,
          itemBuilder: (asset) =>
              AssetCardComponent(asset: asset, onTap: () => router.push(AssetDetailScreen.route(asset.id))),
        ),
      ),
    ];
  }
}

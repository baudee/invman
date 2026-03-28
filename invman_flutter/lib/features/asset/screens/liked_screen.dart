import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class LikedAssetsScreen extends HookWidget {
  const LikedAssetsScreen({super.key});

  static const pathSegment = 'liked';
  static String route() => '${AssetRoutes.namespace}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<LikedAssetListController>());

    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).asset_liked)),
      body: InfiniteListComponent<Asset>(
        controller: controller,
        itemBuilder: (asset) =>
            AssetTileComponent(asset: asset, onTap: (_) => router.push(AssetDetailScreen.route(asset.id))),
      ),
    );
  }
}

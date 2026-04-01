import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class PopularAssetsScreen extends HookWidget {
  final AssetType type;
  const PopularAssetsScreen({super.key, required this.type});

  static const pathSegment = 'popular';
  static String route() => '${AssetRoutes.namespace}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<PopularAssetListController>(param1: type), [type]);

    return BaseScreen(
      appBar: AppBar(title: Text("${S.of(context).core_popular} ${S.of(context).asset_type_plural(type)}")),
      body: InfiniteListComponent<Asset>(
        controller: controller,
        itemBuilder: (asset) =>
            AssetTileComponent(asset: asset, onTap: (_) => router.push(AssetDetailScreen.route(asset.id))),
      ),
    );
  }
}

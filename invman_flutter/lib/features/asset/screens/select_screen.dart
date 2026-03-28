import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetSelectScreen extends HookWidget {
  const AssetSelectScreen({super.key});

  static const pathSegment = 'select';
  static String route() => '${AssetRoutes.namespace}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<AssetSearchListController>());
    return BaseScreen(
      appBar: AppBar(title: AssetSearchComponent(controller: controller)),
      body: InfiniteListComponent(
        refreshIndicator: false,
        controller: controller,
        itemBuilder: (asset) => AssetTileComponent(asset: asset, onTap: (_) => router.pop(asset)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/asset/asset.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AssetSearchScreen extends HookWidget {
  const AssetSearchScreen({super.key});

  static const pathSegment = 'search';
  static String route() => '${AssetRoutes.namespace}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<AssetSearchListController>());

    return BaseScreen(
      appBar: AppBar(
        title: AssetSearchComponent(controller: controller),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(UIConstants.spacingMd), child: SizedBox.shrink()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => AssetFilterSheet(controller: controller),
        ),
        child: Watch((context) {
          final hasFilters = controller.type.value != null || controller.exchange.value != null;
          return Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.filter_list),
              if (hasFilters)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
      body: InfiniteListComponent(
        refreshIndicator: false,
        controller: controller,
        itemBuilder: (asset) =>
            AssetTileComponent(asset: asset, onTap: (_) => router.push(AssetDetailScreen.route(asset.id))),
      ),
    );
  }
}

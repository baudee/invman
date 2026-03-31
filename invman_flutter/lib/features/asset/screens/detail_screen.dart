import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetDetailScreen extends HookWidget {
  final UuidValue uuid;
  const AssetDetailScreen({super.key, required this.uuid});

  static const pathSegment = ':uuid';
  static String route(UuidValue uuid) => '${AssetRoutes.namespace}/$uuid';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<AssetDetailController>(param1: uuid));
    final userPreferencesManager = getIt<UserPreferencesManager>();
    return BaseScreen(
      usePadding: false,
      extendBodyBehindAppBar: true,
      useTopSafeArea: false,
      appBar: BaseStateAppbar<Asset>(
        state: controller.state,
        successBuilder: (asset) => AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            LikeButtonComponent(
              asset: asset,
              onPressed: () async {
                final error = await controller.toggleLike();
                if (error != null) {
                  ToastUtils.message(error, success: false);
                }
              },
            ),
          ],
        ),
      ),
      body: BaseStateComponent<Asset>(
        state: controller.state,
        onReload: controller.reload,
        successBuilder: (asset) =>
            AssetDetailComponent(controller: controller, userPreferencesManager: userPreferencesManager),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetRoutes {
  static String namespace = "/assets";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Asset Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: AssetRootScreen.pathSegment,
        builder: (_, _) => const AssetRootScreen(),
        routes: [
          GoRoute(path: AssetSearchScreen.pathSegment, builder: (_, _) => const AssetSearchScreen()),
          GoRoute(path: AssetSelectScreen.pathSegment, builder: (_, _) => const AssetSelectScreen()),
          GoRoute(
            path: PopularAssetsScreen.pathSegment,
            builder: (_, state) {
              AssetType type;
              if (state.extra != null) {
                if (state.extra is AssetType) {
                  type = state.extra as AssetType;
                } else {
                  type = AssetType.stock;
                }
              } else {
                type = AssetType.stock;
              }

              return PopularAssetsScreen(
                type: type,
              );
            },
          ),
          GoRoute(path: LikedAssetsScreen.pathSegment, builder: (_, _) => const LikedAssetsScreen()),
          GoRoute(
            path: AssetDetailScreen.pathSegment,
            builder: (_, state) => AssetDetailScreen(uuid: UuidValue.fromString(state.pathParameters['uuid'] ?? '')),
          ),
        ],
      ),
    ],
  );
}

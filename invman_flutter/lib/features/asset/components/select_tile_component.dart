import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetSelectTileComponent extends StatelessWidget {
  final Asset? asset;
  final void Function(Asset) onAssetSelected;
  const AssetSelectTileComponent({super.key, required this.asset, required this.onAssetSelected});

  @override
  Widget build(BuildContext context) {
    if (asset == null || asset!.symbol.isEmpty) {
      return ListTile(
        title: Text(S.of(context).asset_add),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final object = await router.push(AssetSelectScreen.route());
          if (object is Asset) {
            onAssetSelected(object);
          }
        },
      );
    } else {
      return AssetTileComponent(
        trailing: Icon(Icons.arrow_forward_ios),
        asset: asset!,
        onTap: (_) async {
          final object = await router.push(AssetSelectScreen.route());
          if (object is Asset) {
            onAssetSelected(object);
          }
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetTileComponent extends StatelessWidget {
  final Asset asset;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(Asset asset)? onTap;

  const AssetTileComponent({super.key, required this.asset, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      leading: AvatarComponent(asset: asset),
      title: Text(asset.name),
      subtitle: Text('${asset.symbol} - ${S.of(context).asset_type(asset.type.name)}'),
      trailing: trailing ?? Text("${asset.price?.toStringAsFixed(2)} ${asset.currency?.code}"),
      onTap: onTap != null ? () => onTap!(asset) : null,
    );
  }
}

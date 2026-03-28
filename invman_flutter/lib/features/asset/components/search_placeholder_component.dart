import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class AssetSearchPlaceholderComponent extends StatelessWidget {
  final VoidCallback onTap;

  const AssetSearchPlaceholderComponent({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: SearchBar(hintText: S.of(context).asset_searchHint, leading: const Icon(Icons.search)),
      ),
    );
  }
}

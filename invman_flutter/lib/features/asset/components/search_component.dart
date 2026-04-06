import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetSearchComponent extends HookWidget {
  final AssetSearchListController controller;
  const AssetSearchComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DebouncingSearchBar(
      hintText: S.of(context).asset_searchHint,
      autoFocus: true,
      debounceMs: 400,
      onChanged: (value) {
        controller.setQuery(value);
      },
      text: controller.query.value,
    );
  }
}

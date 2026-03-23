import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchComponent extends HookWidget {
  final StockSearchListController controller;
  const StockSearchComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DebouncingSearchBar(
      hintText: S.of(context).stock_searchHint,
      autoFocus: true,
      onChanged: (value) {
        controller.query.value = value;
      },
      text: controller.query.value,
    );
  }
}

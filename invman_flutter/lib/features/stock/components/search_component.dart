import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchComponent extends HookWidget {
  const StockSearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockSearchListController>());
    return DebouncingSearchBar(
      hintText: S.of(context).stock_searchHint,
      autoFocus: true,
      onChanged: (value) {
        if (value.isEmpty) {
          controller.clear();
          return;
        }
        controller.search(value);
      },
    );
  }
}

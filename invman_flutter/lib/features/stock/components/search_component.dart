import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchComponent extends ConsumerWidget {
  const StockSearchComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(stockSearchListProvider.notifier);
    return DebouncingSearchBar(
      hintText: S.of(context).stock_searchHint,
      autoFocus: true,
      onChanged: (value) {
        if (value.isEmpty) {
          provider.clear();
          return;
        }
    
        provider.search(value);
      },
    );
  }
}

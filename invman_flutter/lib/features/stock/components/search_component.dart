import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchComponent extends ConsumerWidget {
  const StockSearchComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: () => context.pop(), icon: Icon(Icons.arrow_back)),
            Expanded(
              child: DebouncingSearchBar(
                hintText: "Search for a stock...",
                text: ref.read(stockSearchProvider),
                autoFocus: true,
                onChanged: (v) {
                  ref.read(stockSearchProvider.notifier).state = v.trim();
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: StockListComponent(
            type: StockListType.search,
            addable: true,
            useRefreshIndicator: false,
          ),
        ),
      ],
    );
  }
}

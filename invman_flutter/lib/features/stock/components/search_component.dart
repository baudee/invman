import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
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
                hintText: S.of(context).stock_searchHint,
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
            useRefreshIndicator: false,
            trailing: Icon(Icons.add),
            onTap: (stock) async {
              final result = await ref.read(stockServiceProvider).save(stock);
              ref.read(stockListProvider(StockListType.all).notifier).refresh();

              if (context.mounted) {
                result.fold(
                  (error) {
                    ToastUtils.message(context, error);
                  },
                  (data) {
                    ToastUtils.message(context, S.of(context).stock_added);
                    context.pop();
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

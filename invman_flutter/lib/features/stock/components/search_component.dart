import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockSearchComponent extends ConsumerWidget {
  const StockSearchComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(stockSearchListProvider.notifier);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2 * UIConstants.appPadding),
          child: DebouncingSearchBar(
            hintText: S.of(context).stock_searchHint,
            autoFocus: true,
            onChanged: (value) {
              if (value.isEmpty) {
                provider.clear();
                return;
              }

              provider.search(value);
            },
          ),
        ),
        Expanded(
          child: BaseStateComponent<List<Stock>>(
            state: ref.watch(stockSearchListProvider),
            successBuilder: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final stock = data[index];
                return StockTileComponent(
                  stock: stock,
                  onTap: (stock) async {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

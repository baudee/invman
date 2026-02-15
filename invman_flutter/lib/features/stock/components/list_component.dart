import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockListComponent extends HookWidget {
  final void Function(Stock stock)? onTileTap;
  const StockListComponent({super.key, this.onTileTap});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockSearchListController>());
    return BaseStateComponent<List<Stock>>(
      state: controller.state,
      successBuilder: (data) => data.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return StockTileComponent(stock: data[index], onTap: onTileTap);
              },
            ),
    );
  }
}

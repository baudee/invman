import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailScreen extends HookWidget {
  final UuidValue uuid;
  const StockDetailScreen({super.key, required this.uuid});

  static String route([UuidValue? uuid]) => "${StockRoutes.namespace}/${uuid ?? ':uuid'}";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockDetailController>(param1: uuid));
    return BaseScreen(
      appBar: AppBar(
        title: controller.value.map(
          data: (stock) => Text(stock.shortName),
          error: (_, _) => null,
          loading: () => null,
        ),
      ),
      body: BaseStateComponent<Stock>(
        state: controller,
        successBuilder: (stock) => StockDetailComponent(stock: stock),
      ),
    );
  }
}

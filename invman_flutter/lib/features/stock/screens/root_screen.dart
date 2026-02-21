import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRootScreen extends HookWidget {
  const StockRootScreen({super.key});

  static String route() => StockRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockRootController>());

    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).stock_title)),
      body: StockRootComponent(controller: controller),
    );
  }
}

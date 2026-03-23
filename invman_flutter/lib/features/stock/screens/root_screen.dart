import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockRootScreen extends HookWidget {
  const StockRootScreen({super.key});

  static const pathSegment = '/stocks';
  static String route() => pathSegment;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<StockRootController>());

    return BaseScreen(
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/images/logo.webp")),
        title: Text(AppConstants.appName, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: StockRootComponent(controller: controller),
    );
  }
}

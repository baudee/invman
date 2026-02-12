import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/stock/stock.dart';

class StockDetailScreen extends BaseScreen {
  final UuidValue uuid;
  const StockDetailScreen({super.key, required this.uuid});

  static String route([UuidValue? uuid]) => "${StockRoutes.namespace}/${uuid ?? ':uuid'}";

  @override
  AppBar? appBar(BuildContext context) {
    final state = getIt<StockDetailController>(param1: uuid);
    return state.value.map(
      data: (stock) => AppBar(title: Text(stock.shortName)),
      error: (error, _) => AppBar(),
      loading: () => AppBar(),
    );
  }

  @override
  Widget body(BuildContext context) {
    return BaseStateComponent<Stock>(
      state: getIt<StockDetailController>(param1: uuid),
      successBuilder: (stock) => StockDetailComponent(stock: stock),
    );
  }
}

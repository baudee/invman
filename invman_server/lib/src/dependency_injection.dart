import 'package:get_it/get_it.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/stock/stock.dart';

final GetIt getIt = GetIt.instance;

void initDependencyInjection() {
  // Env
  getIt.registerSingleton<Env>(Env());

  // Data
  getIt.registerSingleton<StockApi>(StockApiImpl(apiKey: getIt<Env>().twelvedataApiKey));

  // Services
  getIt.registerSingleton<StockService>(StockService(stockApi: getIt<StockApi>()));
}

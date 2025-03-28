import 'package:get_it/get_it.dart';
import 'package:invman_server/src/auth/auth.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:invman_server/src/transfer/transfer.dart';

final GetIt getIt = GetIt.instance;

void initDependencyInjection() {
  // Env
  getIt.registerSingleton<Env>(Env());

  // Data
  getIt.registerSingleton<StockApi>(StockApiImpl(apiKey: getIt<Env>().fmpApiKey));

  // Services
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<StockService>(StockService(stockApi: getIt<StockApi>()));
  getIt.registerSingleton<TransferService>(TransferService());
}

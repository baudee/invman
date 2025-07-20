import 'package:get_it/get_it.dart';
import 'package:invman_server/src/auth/auth.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/investment/investment.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:invman_server/src/transfer/transfer.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';

final GetIt getIt = GetIt.instance;

void initDependencyInjection() {
  // Env
  getIt.registerSingleton<Env>(Env());

  // Data
  getIt.registerSingleton<StockClient>(StockClientImpl(baseUrl: getIt<Env>().yfinBaseUrl));

  // Business
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<StockService>(StockService(stockClient: getIt<StockClient>()));
  getIt.registerSingleton<WithdrawalRuleService>(WithdrawalRuleService());
  getIt.registerSingleton<InvestmentService>(
    InvestmentService(
      withdrawalRuleService: getIt<WithdrawalRuleService>(),
      stockClient: getIt<StockClient>(),
    ),
  );
  getIt.registerSingleton<TransferService>(TransferService(investmentService: getIt<InvestmentService>()));
  getIt.registerSingleton<WithdrawalFeeService>(WithdrawalFeeService(ruleService: getIt<WithdrawalRuleService>()));
}

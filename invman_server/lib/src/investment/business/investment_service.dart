import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:serverpod/serverpod.dart';

class InvestmentService {
  final StockClient stockClient;

  InvestmentService({required this.stockClient});

  Future<InvestmentList> list(
    Session session, {
    required String currency,
    int limit = 10,
    int page = 1,
  }) async {
    final sessionUser = await session.authenticated;

    final count = await Investment.db.count(session, where: (e) => e.userId.equals(sessionUser!.userId));

    final investments = await Investment.db.find(
      session,
      limit: limit,
      offset: (page * limit) - limit,
      where: (e) => e.userId.equals(sessionUser!.userId),
      include: IncludeHelpers.investmentInclude(),
    );

    for (var investment in investments) {
      final stock = await stockClient.get(symbol: investment.stockSymbol);
      final transfers = investment.transfers ?? [];

      int investAmount = transfers.map((e) => e.amount).reduce((v, e) => v + e);
      double quantity = transfers.map((e) => e.quantity).reduce((v, e) => v + e);

      double amountBeforeFees = quantity * stock.value;
      double totalFees = 0;

      final withdrawalRule = investment.withdrawalRule;
      final feeList = withdrawalRule?.rules ?? [];
      for (final feeRule in feeList) {
        double fee = feeRule.fixed + amountBeforeFees * feeRule.percent / 100;
        if (fee < feeRule.minimum) {
          fee = feeRule.minimum;
        }
        totalFees += fee;
      }

      double actualAmount = amountBeforeFees - totalFees;

      if (currency != stock.currency) {
        // TODO
        // Get conversion rate
        // add percentage fee
        // convert
      }

      investment = investment.copyWith(
        stock: stock,
        investAmount: investAmount,
        withdrawAmount: (actualAmount * 100).toInt(),
      );
    }

    return InvestmentList(
      count: count,
      limit: limit,
      page: page,
      results: investments,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }

  Future<Investment> total(
    Session session, {
    required String currency,
    required double percentageCurrencyChangeFee,
  }) async {
    final sessionUser = await session.authenticated;

    /*final stocks = await Stock.db.find(
      session,
      where: (s) => s.transfers.any((t) => t.userId.equals(sessionUser.userId)),
      include: IncludeHelpers.stockInclude(sessionUser!.userId),
    );

    final withdrawalRules = await Withdrawal.db.find(session, where: (e) => e.userId.equals(sessionUser.userId));

    int totalInvestAmount = 0;
    double totalAmountBeforeFees = 0;
    for (final stock in stocks) {
      final transfers = stock.transfers ?? [];
      int investAmount = transfers.map((e) => e.amount).reduce((v, e) => v + e);
      double quantity = transfers.map((e) => e.quantity).reduce((v, e) => v + e);
      double amountBeforeFees = quantity * stock.value;

      if (currency != stock.currency) {
        // TODO
        // Get conversion rate
        // add percentage fee
        // convert
      }

      totalInvestAmount += investAmount;
      totalAmountBeforeFees += amountBeforeFees;
    }

    double totalFees = 0;
    for (final rule in withdrawalRules) {
      double fee = rule.fixed + totalAmountBeforeFees * rule.percent / 100;
      if (fee < rule.minimum) {
        fee = rule.minimum;
      }
      totalFees += fee;
    }

    double actualAmount = totalAmountBeforeFees - totalFees;*/
    return Investment(
        //stock: Stock(symbol: 'TOTAL', name: 'Total', currency: currency, quoteType: 'quoteType'),
        //investAmount: totalInvestAmount,
        //withdrawAmount: (actualAmount * 100).toInt(),
        userId: 0,
        withdrawalRuleId: 0,
        stockSymbol: '',
        stock: Stock(symbol: 'TOTAL', name: 'Total', currency: currency, quoteType: 'quoteType', value: -1),
        investAmount: 0,
        withdrawAmount: 0);
  }
}

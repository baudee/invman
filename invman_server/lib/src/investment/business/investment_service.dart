import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';

class InvestmentService {
  final StockClient stockClient;
  final WithdrawalRuleService withdrawalRuleService;

  InvestmentService({required this.stockClient, required this.withdrawalRuleService});

  Future<Investment> addRentabilityAndStock({required Investment investment, required String currency}) async {
    final stock = await stockClient.get(symbol: investment.stockSymbol);
    final transfers = investment.transfers ?? [];

    double investAmount = transfers.map((e) => e.amount).fold(0, (v, e) => v + e);
    double quantity = transfers.map((e) => e.quantity).fold(0, (v, e) => v + e);

    double amountBeforeFees = quantity * stock.value;
    double totalFees = 0;

    final withdrawalRule = investment.withdrawalRule;
    final feeList = withdrawalRule?.fees ?? [];
    if (quantity != 0) {
      for (final feeRule in feeList) {
        double fee = feeRule.fixed + amountBeforeFees * feeRule.percent / 100;
        if (fee < feeRule.minimum) {
          fee = feeRule.minimum;
        }
        totalFees += fee;
      }
    }

    double actualAmount = amountBeforeFees - totalFees;

    if (currency != stock.currency) {
      double change = await stockClient.currencyChange(from: stock.currency, to: currency);
      change = change + (withdrawalRule?.currencyChangePercentage ?? 0) / 100;
      actualAmount *= change;
    }

    investment = investment.copyWith(
      stock: stock,
      investAmount: investAmount,
      withdrawAmount: actualAmount,
    );
    return investment;
  }

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
      orderBy: (e) => e.updatedAt,
      orderDescending: true,
      include: IncludeHelpers.investmentInclude(),
    );

    List<Investment> cleanedInvestments = [];
    for (final investment in investments) {
      Investment cleanInvestment = await addRentabilityAndStock(investment: investment, currency: currency);
      // Remove unnecessary data
      cleanInvestment = cleanInvestment.copyWith(
        transfers: null,
        withdrawalRule: null,
        stock: null,
      );
      cleanedInvestments.add(cleanInvestment);
    }

    return InvestmentList(
      count: count,
      limit: limit,
      page: page,
      results: cleanedInvestments,
      numPages: (count / limit).ceil(),
      canLoadMore: page * limit < count,
    );
  }

  Future<Investment> total(
    Session session, {
    required String currency,
  }) async {
    final sessionUser = await session.authenticated;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUser!.userId),
      include: IncludeHelpers.investmentInclude(),
    );

    double totalInvestAmount = 0;
    double totalWithdrawAmount = 0;
    for (final investment in investments) {
      final cleanInvestment = await addRentabilityAndStock(investment: investment, currency: currency);
      totalInvestAmount += cleanInvestment.investAmount ?? 0;
      totalWithdrawAmount += cleanInvestment.withdrawAmount ?? 0;
    }

    return Investment(
      userId: 0,
      name: 'TOTAL',
      withdrawalRuleId: 0,
      stockSymbol: '',
      stock: null,
      investAmount: totalInvestAmount,
      withdrawAmount: totalWithdrawAmount,
    );
  }

  Future<Investment> save(Session session, Investment investment, {required String currency}) async {
    if (investment.name.isEmpty) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    return session.db.transaction(
      (transaction) async {
        await withdrawalRuleService.retrieve(session, investment.withdrawalRuleId, transaction: transaction);
        await stockClient.get(symbol: investment.stockSymbol);

        if (investment.id == 0 || investment.id == null) {
          investment = investment.copyWith(userId: (await session.authenticated)!.userId);
          return Investment.db.insertRow(session, investment, transaction: transaction);
        } else {
          await retrieve(session, investment.id!, currency: currency);
          return Investment.db.updateRow(session, investment, transaction: transaction);
        }
      },
      settings: TransactionSettings(isolationLevel: IsolationLevel.serializable),
    );
  }

  Future<void> retrieveChecks(Session session, {required Investment? investment}) async {
    if (investment == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final sessionUser = await session.authenticated;
    if (investment.userId != sessionUser!.userId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }
  }

  Future<Investment> retrieve(Session session, int id, {required String currency}) async {
    Investment? investment = await Investment.db.findById(
      session,
      id,
      include: IncludeHelpers.investmentInclude(),
    );

    await retrieveChecks(session, investment: investment);

    investment = await addRentabilityAndStock(investment: investment!, currency: currency);

    return investment;
  }

  Future<Investment> delete(Session session, int id) async {
    return session.db.transaction(
      (transaction) async {
        Investment? investment = await Investment.db.findById(
          session,
          id,
        );
        await retrieveChecks(session, investment: investment);
        return Investment.db.deleteRow(session, investment!);
      },
      settings: TransactionSettings(isolationLevel: IsolationLevel.serializable),
    );
  }
}

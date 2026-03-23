import 'package:injectable/injectable.dart';
import 'package:invman_server/src/account/account.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/currency/currency.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/stock/stock.dart';
import 'package:invman_server/src/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class InvestmentService {
  final AccountService accountService;
  final CurrencyService currencyService;
  final StockService stockService;
  final WithdrawalRuleService withdrawalRuleService;
  final Env env;

  InvestmentService({
    required this.accountService,
    required this.currencyService,
    required this.stockService,
    required this.withdrawalRuleService,
    required this.env,
  });

  Future<List<Investment>> list(
    Session session, {
    required int limit,
    required int page,
  }) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    List<Investment> investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
      limit: limit,
      offset: (page * limit) - limit,
      orderBy: (e) => e.updatedAt,
      orderDescending: true,
    );

    // Add withdrawal amount for all investments
    for (var i = 0; i < investments.length; i++) {
      investments[i] = await _addWithdrawAmount(
        session,
        investment: investments[i],
        stock: investments[i].stock!,
      );
    }

    return investments;
  }

  Future<Investment> total(Session session) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    final investmentsUpToDate = <Investment>[];
    final investmentsToUpdate = <Investment>[];
    for (var i = 0; i < investments.length; i++) {
      final investment = investments[i];
      final stock = investment.stock;
      if (stock!.updatedAt.isBefore(DateTime.now().subtract(Duration(days: env.cacheDurationDays)))) {
        investmentsToUpdate.add(investment);
      } else {
        investmentsUpToDate.add(investment);
      }
    }

    // Update necessary stocks
    if (investmentsToUpdate.isNotEmpty) {
      final stocksToUpdate = investmentsToUpdate.map((e) => e.stock!).toList();
      final updatedStocks = await stockService.addCurrentValues(session, stocksToUpdate);
      for (var i = 0; i < investmentsToUpdate.length; i++) {
        final investment = investmentsToUpdate[i];
        final correspondingUpdatedStock = updatedStocks.firstWhere((s) => s.id == investment.stockId);
        investmentsUpToDate.add(
          investment.copyWith(
            stock: correspondingUpdatedStock,
            stockId: correspondingUpdatedStock.id,
          ),
        );
      }
    }

    // Add withdrawal amount for all investments
    double totalInvestAmount = 0;
    double totalWithdrawAmount = 0;
    for (var i = 0; i < investmentsUpToDate.length; i++) {
      investmentsUpToDate[i] = await _addWithdrawAmount(
        session,
        investment: investmentsUpToDate[i],
        stock: investmentsUpToDate[i].stock!,
      );
      totalInvestAmount += investmentsUpToDate[i].investAmount;
      totalWithdrawAmount += investmentsUpToDate[i].withdrawAmount ?? 0;
    }

    return Investment(
      userId: UuidValue.fromString(Namespace.nil.value),
      name: 'TOTAL',
      withdrawalRuleId: 0,
      stock: null,
      investAmount: totalInvestAmount,
      withdrawAmount: totalWithdrawAmount,
      stockId: UuidValue.fromString(Namespace.nil.value),
    );
  }

  Future<Investment> save(Session session, Investment investment) async {
    if (investment.name.isEmpty ||
        investment.withdrawalRuleId == 0 ||
        investment.stockId == UuidValue.fromString(Namespace.nil.value)) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }
    return session.db.transaction(
      (transaction) async {
        if (investment.withdrawalRuleId != null) {
          await withdrawalRuleService.retrieve(
            session,
            investment.withdrawalRuleId!,
            transaction: transaction,
          );
        }
        final stock = await stockService.retrieve(
          session,
          investment.stockId,
          transaction: transaction,
        );
        investment = investment.copyWith(
          userId: (session.authenticated)!.authUserId,
          stockId: stock.id,
        );

        if (investment.id == 0 || investment.id == null) {
          return Investment.db.insertRow(
            session,
            investment.copyWith(id: null),
            transaction: transaction,
          );
        } else {
          await retrieve(session, investment.id!, transaction: transaction);
          return Investment.db.updateRow(
            session,
            investment,
            transaction: transaction,
          );
        }
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  Future<Investment> retrieve(
    Session session,
    int id, {
    Transaction? transaction,
  }) async {
    Investment? investment = await Investment.db.findById(
      session,
      id,
      include: IncludeHelpers.investmentInclude(),
      transaction: transaction,
    );

    if (investment == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    final sessionUser = session.authenticated;
    if (investment.userId != sessionUser!.authUserId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return _addWithdrawAmountAndStock(
      session,
      investment: investment,
    );
  }

  Future<Investment> delete(Session session, int id) async {
    return session.db.transaction(
      (transaction) async {
        Investment? investment = await Investment.db.findById(
          session,
          id,
        );
        await retrieve(session, id);
        return Investment.db.deleteRow(session, investment!);
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  Future<void> updateTotalTransfers(
    Session session,
    int investmentId, {
    Transaction? transaction,
  }) async {
    final investment = await retrieve(
      session,
      investmentId,
      transaction: transaction,
    );
    final transfers = await Transfer.db.find(
      session,
      where: (e) => e.investmentId.equals(investmentId),
      transaction: transaction,
    );

    double totalInvested = 0;
    double totalQuantity = 0;
    for (final transfer in transfers) {
      totalInvested += transfer.amount;
      totalQuantity += transfer.quantity;
    }
    await Investment.db.updateRow(
      session,
      investment.copyWith(
        investAmount: totalInvested,
        quantity: totalQuantity,
        updatedAt: DateTime.now(),
      ),
      transaction: transaction,
    );
  }

  Future<Investment> _addWithdrawAmountAndStock(
    Session session, {
    required Investment investment,
  }) async {
    final stock = await stockService.retrieve(session, investment.stockId);

    return _addWithdrawAmount(session, investment: investment, stock: stock);
  }

  Future<Investment> _addWithdrawAmount(
    Session session, {
    required Investment investment,
    required Stock stock,
  }) async {
    double amountBeforeFees = investment.quantity * (stock.price);
    double totalFees = 0;

    final withdrawalRule = investment.withdrawalRule;
    final feeList = withdrawalRule?.fees ?? [];
    if (investment.quantity != 0) {
      for (final feeRule in feeList) {
        double fee = feeRule.fixed + amountBeforeFees * feeRule.percent / 100;
        if (fee < feeRule.minimum) {
          fee = feeRule.minimum;
        }
        totalFees += fee;
      }
    }

    double actualAmount = amountBeforeFees - totalFees;

    final accountCurrency = (await accountService.retrieve(session)).currency;
    if (accountCurrency?.id != stock.currency?.id) {
      double change = await currencyService.change(session, fromId: stock.currencyId, toId: accountCurrency?.id);
      change = change - (withdrawalRule?.currencyChangePercentage ?? 0) / 100;
      actualAmount *= change;
    }

    investment = investment.copyWith(
      stock: stock,
      withdrawAmount: actualAmount,
    );
    return investment;
  }
}

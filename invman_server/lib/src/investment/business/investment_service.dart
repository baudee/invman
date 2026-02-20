import 'package:injectable/injectable.dart';
import 'package:invman_server/src/account/account.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/currency/currency.dart';
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

  InvestmentService({
    required this.accountService,
    required this.currencyService,
    required this.stockService,
    required this.withdrawalRuleService,
  });

  Future<Investment> _addWithdrawAmountAndStock(
    Session session, {
    required Investment investment,
    Transaction? transaction,
  }) async {
    final stock = await stockService.retrieve(session, investment.stockId);

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
      double change = await currencyService.change(
        session,
        from: stock.currency,
        to: accountCurrency,
      );
      change = change - (withdrawalRule?.currencyChangePercentage ?? 0) / 100;
      actualAmount *= change;
    }

    investment = investment.copyWith(
      stock: stock,
      withdrawAmount: actualAmount,
    );
    return investment;
  }

  Future<List<Investment>> list(Session session) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    for (var i = 0; i < investments.length; i++) {
      investments[i] = await _addWithdrawAmountAndStock(
        session,
        investment: investments[i],
      );
    }

    investments.sort((a, b) => a.withdrawAmount!.compareTo(b.withdrawAmount!));

    return investments;
  }

  Future<Investment> save(Session session, Investment investment) async {
    if (investment.name.isEmpty || investment.stock == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    return session.db.transaction(
      (transaction) async {
        await withdrawalRuleService.retrieve(
          session,
          investment.withdrawalRuleId,
          transaction: transaction,
        );
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
      transaction: transaction,
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
}

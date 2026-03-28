import 'package:injectable/injectable.dart';
import 'package:invman_server/src/features/account/account.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/features/currency/currency.dart';
import 'package:invman_server/src/env.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:invman_server/src/features/asset/asset.dart';
import 'package:invman_server/src/features/withdrawal/withdrawal.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class InvestmentService {
  final AccountService accountService;
  final CurrencyService currencyService;
  final AssetService assetService;
  final WithdrawalRuleService withdrawalRuleService;
  final Env env;

  InvestmentService({
    required this.accountService,
    required this.currencyService,
    required this.assetService,
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
      investments[i] = await _addWithdrawAmountAndAsset(
        session,
        investment: investments[i],
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

    // Add withdrawal amount for all investments
    double totalInvestAmount = 0;
    double totalWithdrawAmount = 0;
    for (var i = 0; i < investments.length; i++) {
      investments[i] = await _addWithdrawAmountAndAsset(
        session,
        investment: investments[i],
      );
      totalInvestAmount += investments[i].investAmount;
      totalWithdrawAmount += investments[i].withdrawAmount ?? 0;
    }

    return Investment(
      userId: UuidValue.fromString(Namespace.nil.value),
      name: 'TOTAL',
      withdrawalRuleId: 0,
      asset: null,
      investAmount: totalInvestAmount,
      withdrawAmount: totalWithdrawAmount,
      assetId: UuidValue.fromString(Namespace.nil.value),
    );
  }

  Future<Investment> save(Session session, Investment investment) async {
    if (investment.name.isEmpty ||
        investment.withdrawalRuleId == 0 ||
        investment.assetId == UuidValue.fromString(Namespace.nil.value)) {
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
        final asset = await assetService.retrieve(
          session,
          investment.assetId,
          transaction: transaction,
        );
        investment = investment.copyWith(
          userId: (session.authenticated)!.authUserId,
          assetId: asset.id,
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

    return _addWithdrawAmountAndAsset(
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

  Future<Investment> _addWithdrawAmountAndAsset(
    Session session, {
    required Investment investment,
  }) async {
    final asset = await assetService.retrieve(session, investment.assetId);

    double amountBeforeFees = investment.quantity * (asset.price!);
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
    Forex? forex;
    if (accountCurrency?.id != asset.currency?.id) {
      forex = await currencyService.change(session, fromId: asset.currencyId, toId: accountCurrency?.id);
      forex = forex.copyWith(rate: forex.rate - (withdrawalRule?.currencyChangePercentage ?? 0) / 100);
      actualAmount *= forex.rate;
    }

    investment = investment.copyWith(
      asset: asset,
      withdrawAmount: actualAmount,
      forex: forex,
    );
    return investment;
  }
}

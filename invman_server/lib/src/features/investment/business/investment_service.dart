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
  final AssetValuesSource assetsValuesSource;
  final WithdrawalRuleService withdrawalRuleService;
  final Env env;

  InvestmentService({
    required this.accountService,
    required this.currencyService,
    required this.assetService,
    required this.assetsValuesSource,
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
    bool computeWithdrawAmount = true,
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

    if (computeWithdrawAmount) {
      investment = await _addWithdrawAmountAndAsset(
        session,
        investment: investment,
      );
    }

    return investment;
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

  Future<void> refresh(
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

  Future<List<InvestmentReturn>> returns(
    Session session,
    int investmentId, {
    required InvestmentReturnInterval interval,
  }) async {
    final investment = await retrieve(session, investmentId, computeWithdrawAmount: false);

    final cacheKey = CacheKeys.investmentReturns(investmentId, interval);
    List<InvestmentReturn>? returns = await session.caches.local.get(cacheKey);

    if (returns == null) {
      final accountCurrency = (await accountService.retrieve(session)).currency;
      final now = DateTime.timestamp();

      final isMonthly = interval == InvestmentReturnInterval.monthly;
      final startDate = isMonthly ? DateTime(now.year - 1, now.month, now.day) : null;

      final transfers = await Transfer.db.find(
        session,
        where: (e) =>
            e.investmentId.equals(investmentId) & (startDate != null ? e.createdAt > startDate : Constant.bool(true)),
      );

      final Map<int, List<Transfer>> groupedTransfers = {};
      for (final t in transfers) {
        final key = isMonthly ? t.createdAt.month : t.createdAt.year;
        groupedTransfers.putIfAbsent(key, () => []).add(t);
      }

      returns = [];
      for (final entry in groupedTransfers.entries) {
        final key = entry.key;
        final group = entry.value;

        final year = isMonthly
            ? key > now.month
                  ? now.year - 1
                  : now.year
            : key + 1;
        final month = isMonthly ? key + 1 : 1;

        final calculationDate = DateTime(year, month, 1);

        final totalInvested = group.fold(0.0, (sum, t) => sum + t.amount);
        final totalQuantity = group.fold(0.0, (sum, t) => sum + t.quantity);

        final assetValue = await assetsValuesSource.getEodValue(
          asset: investment.asset!,
          date: calculationDate.add(const Duration(days: 1)),
        );

        Forex? forex;
        if (accountCurrency?.id != investment.asset?.currency?.id) {
          forex = await currencyService.changeEod(
            session,
            fromCode: investment.asset!.currency!.code,
            toCode: accountCurrency!.code,
            date: calculationDate,
          );
        }

        final withdrawAmount = _computeWithdrawAmount(
          session,
          quantity: totalQuantity,
          assetValue: assetValue.value,
          currencyChangeRate: forex?.rate ?? 1,
          withdrawalRule: investment.withdrawalRule,
        );

        final returnPercentage = totalInvested != 0 ? (withdrawAmount - totalInvested) / totalInvested * 100 : 0.0;

        returns.add(
          InvestmentReturn(
            percentage: returnPercentage,
            gains: withdrawAmount - totalInvested,
            year: isMonthly ? year : year - 1,
            month: month - 1,
          ),
        );
      }
      await session.caches.local.put(
        cacheKey,
        returns,
        lifetime: Duration(hours: 1),
      );
    }

    return returns;
  }

  Future<Investment> _addWithdrawAmountAndAsset(
    Session session, {
    required Investment investment,
  }) async {
    final asset = await assetService.retrieve(session, investment.assetId);

    final accountCurrency = (await accountService.retrieve(session)).currency;
    Forex? forex;
    if (accountCurrency?.id != asset.currency?.id) {
      forex = await currencyService.change(session, fromCode: asset.currency!.code, toCode: accountCurrency!.code);
    }

    final withdrwaAmount = _computeWithdrawAmount(
      session,
      quantity: investment.quantity,
      assetValue: asset.price!,
      currencyChangeRate: forex?.rate ?? 1,
      withdrawalRule: investment.withdrawalRule,
    );

    investment = investment.copyWith(
      asset: asset,
      withdrawAmount: withdrwaAmount,
      forex: forex,
    );
    return investment;
  }

  double _computeWithdrawAmount(
    Session session, {
    required double quantity,
    required double assetValue,
    required double currencyChangeRate,
    WithdrawalRule? withdrawalRule,
  }) {
    double amountBeforeFees = quantity * (assetValue);
    double totalFees = 0;

    final feeList = withdrawalRule?.fees ?? [];
    if (quantity != 0) {
      for (final feeRule in feeList) {
        double fee = feeRule.fixed + amountBeforeFees * feeRule.percent / 100;
        if (fee < feeRule.minimum) {
          fee = feeRule.minimum;
        }
        totalFees += fee;
      }
    } else {
      return 0;
    }

    double withdrawAmount = amountBeforeFees - totalFees;
    final finalRate = currencyChangeRate - (withdrawalRule?.currencyChangePercentage ?? 0) / 100;
    withdrawAmount *= finalRate;
    return withdrawAmount;
  }
}

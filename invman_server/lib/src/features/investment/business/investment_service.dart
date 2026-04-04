import 'dart:math';

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

    double totalInvestAmount = 0;
    double totalWithdrawAmount = 0;
    double totalRealizedProfit = 0;
    double totalUnrealizedProfit = 0;
    double totalTotalProfit = 0;

    for (var i = 0; i < investments.length; i++) {
      investments[i] = await _addWithdrawAmountAndAsset(
        session,
        investment: investments[i],
      );
      totalInvestAmount += investments[i].investAmount;
      totalWithdrawAmount += investments[i].withdrawAmount ?? 0;
      totalRealizedProfit += investments[i].realizedProfit ?? 0;
      totalUnrealizedProfit += investments[i].unrealizedProfit ?? 0;
      totalTotalProfit += investments[i].totalProfit ?? 0;
    }

    // Global XIRR: all transfers across all investments + total liquidation value
    double? globalReturnPercentage;
    final investmentIds = investments.map((e) => e.id).whereType<int>().toSet();
    if (investmentIds.isNotEmpty) {
      final allTransfers = await Transfer.db.find(
        session,
        where: (e) => e.investmentId.inSet(investmentIds),
        orderBy: (e) => e.createdAt,
      );
      if (allTransfers.isNotEmpty) {
        final now = DateTime.timestamp();
        final cashFlows = [...allTransfers.map((t) => -t.amount), totalWithdrawAmount];
        final dates = [...allTransfers.map((t) => t.createdAt), now];
        final xirr = _computeXirr(cashFlows, dates);
        globalReturnPercentage = (xirr ?? 0) * 100;
      }
    }

    return Investment(
      userId: UuidValue.fromString(Namespace.nil.value),
      name: 'TOTAL',
      withdrawalRuleId: 0,
      asset: null,
      investAmount: totalInvestAmount,
      withdrawAmount: totalWithdrawAmount,
      realizedProfit: totalRealizedProfit,
      unrealizedProfit: totalUnrealizedProfit,
      totalProfit: totalTotalProfit,
      returnPercentage: globalReturnPercentage,
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

    final accountCurrency = (await accountService.retrieve(session)).currency;
    final now = DateTime.timestamp();
    final isMonthly = interval == InvestmentReturnInterval.monthly;

    final allTransfers = await Transfer.db.find(
      session,
      where: (e) => e.investmentId.equals(investmentId),
      orderBy: (e) => e.createdAt,
    );

    if (allTransfers.isEmpty) return [];

    final periods = isMonthly ? _buildMonthlyPeriods(now) : _buildYearlyPeriods(now, allTransfers.first.createdAt);
    final List<InvestmentReturn> returns = [];
    for (final period in periods) {
      final periodStart = period.$1;
      final periodEnd = period.$2;
      final periodYear = period.$3;
      final periodMonth = period.$4;
      final isCurrentPeriod = period.$5;

      final openingQuantity = allTransfers
          .where((t) => t.createdAt.isBefore(periodStart))
          .fold(0.0, (sum, t) => sum + t.quantity);

      final periodTransfers = allTransfers
          .where((t) => !t.createdAt.isBefore(periodStart) && !t.createdAt.isAfter(periodEnd))
          .toList();

      final closingQuantity = openingQuantity + periodTransfers.fold(0.0, (sum, t) => sum + t.quantity);

      if (openingQuantity == 0 && periodTransfers.isEmpty) continue;
      if (closingQuantity == 0) continue;

      final needsForex = accountCurrency?.id != investment.asset?.currency?.id;

      // Opening value: use EOD of the day before the period starts so that
      // closing(M) == opening(M+1), making gains chainable across periods.
      final openingEodDate = periodStart.subtract(const Duration(days: 1));
      double openingNetValue = 0;
      if (openingQuantity > 0) {
        final openingEod = await assetsValuesSource.getEodValue(
          session,
          asset: investment.asset!,
          date: openingEodDate,
        );
        Forex? openingForex;
        if (needsForex) {
          openingForex = await currencyService.changeEod(
            session,
            fromCode: investment.asset!.currency!.code,
            toCode: accountCurrency!.code,
            date: openingEodDate,
          );
        }
        openingNetValue = _computeWithdrawAmount(
          session,
          quantity: openingQuantity,
          assetValue: openingEod.value,
          currencyChangeRate: openingForex?.rate ?? 1,
          withdrawalRule: investment.withdrawalRule,
        );
      }

      // Closing value (value at end of period)
      final AssetValue closingEod;
      Forex? closingForex;
      if (isCurrentPeriod) {
        closingEod = await assetsValuesSource.getCurrentValue(session, asset: investment.asset!);
        if (needsForex) {
          closingForex = await currencyService.change(
            session,
            fromCode: investment.asset!.currency!.code,
            toCode: accountCurrency!.code,
          );
        }
      } else {
        closingEod = await assetsValuesSource.getEodValue(
          session,
          asset: investment.asset!,
          date: periodEnd,
        );
        if (needsForex) {
          closingForex = await currencyService.changeEod(
            session,
            fromCode: investment.asset!.currency!.code,
            toCode: accountCurrency!.code,
            date: periodEnd,
          );
        }
      }

      final closingNetValue = _computeWithdrawAmount(
        session,
        quantity: closingQuantity,
        assetValue: closingEod.value,
        currencyChangeRate: closingForex?.rate ?? 1,
        withdrawalRule: investment.withdrawalRule,
      );

      // Build cash flows and dates for IRR
      final cashFlows = <double>[];
      final dates = <DateTime>[];

      if (openingQuantity > 0) {
        cashFlows.add(-openingNetValue);
        dates.add(periodStart);
      }

      for (final t in periodTransfers) {
        cashFlows.add(-t.amount);
        dates.add(t.createdAt);
      }

      cashFlows.add(closingNetValue);
      dates.add(periodEnd);

      final irr = _computeIrr(cashFlows, dates);
      final periodTransferAmount = periodTransfers.fold(0.0, (sum, t) => sum + t.amount);
      final gains = closingNetValue - openingNetValue - periodTransferAmount;

      returns.add(
        InvestmentReturn(
          percentage: (irr ?? 0) * 100,
          gains: gains,
          year: periodYear,
          month: periodMonth,
        ),
      );
    }

    return returns;
  }

  /// Returns a list of (periodStart, periodEnd, year, month, isCurrentPeriod) for the last 12 months.
  List<(DateTime, DateTime, int, int, bool)> _buildMonthlyPeriods(DateTime now) {
    final periods = <(DateTime, DateTime, int, int, bool)>[];
    for (int i = 11; i >= 0; i--) {
      final date = DateTime(now.year, now.month - i, 1);
      final year = date.year;
      final month = date.month;
      final start = DateTime(year, month, 1);
      final isCurrentPeriod = year == now.year && month == now.month;
      // Last day of month: DateTime(year, month + 1, 0) gives day 0 of next month = last day of current month
      final end = isCurrentPeriod ? now : DateTime(year, month + 1, 0);
      periods.add((start, end, year, month, isCurrentPeriod));
    }
    return periods;
  }

  /// Returns a list of (periodStart, periodEnd, year, month, isCurrentPeriod) from firstYear to current year.
  List<(DateTime, DateTime, int, int, bool)> _buildYearlyPeriods(DateTime now, DateTime firstTransferDate) {
    final periods = <(DateTime, DateTime, int, int, bool)>[];
    for (int year = firstTransferDate.year; year <= now.year; year++) {
      final start = DateTime(year, 1, 1);
      final isCurrentPeriod = year == now.year;
      final end = isCurrentPeriod ? now : DateTime(year, 12, 31);
      periods.add((start, end, year, 0, isCurrentPeriod));
    }
    return periods;
  }

  /// Computes the annualized XIRR using Newton-Raphson. Time is expressed in years (days / 365).
  static double? _computeXirr(List<double> cashFlows, List<DateTime> dates) {
    final totalDays = dates.last.difference(dates.first).inDays;
    if (totalDays == 0) return null;

    final t = dates.map((d) => d.difference(dates.first).inDays / 365.0).toList();

    double npv(double r) {
      double sum = 0;
      for (int i = 0; i < cashFlows.length; i++) {
        sum += cashFlows[i] / pow(1 + r, t[i]);
      }
      return sum;
    }

    double dnpv(double r) {
      double sum = 0;
      for (int i = 0; i < cashFlows.length; i++) {
        if (t[i] != 0) {
          sum -= t[i] * cashFlows[i] / pow(1 + r, t[i] + 1);
        }
      }
      return sum;
    }

    double r = 0.1;
    for (int i = 0; i < 100; i++) {
      final f = npv(r);
      final df = dnpv(r);
      if (df.abs() < 1e-10) break;
      final next = r - f / df;
      if ((next - r).abs() < 1e-7) return next;
      r = next.clamp(-0.999, 100.0);
    }
    return r;
  }

  /// Computes the IRR (Internal Rate of Return) for a period using Newton-Raphson.
  /// Time is normalized to [0, 1] over the period so the result is the raw period return.
  static double? _computeIrr(List<double> cashFlows, List<DateTime> dates) {
    final totalDays = dates.last.difference(dates.first).inDays;
    if (totalDays == 0) return null;

    final t = dates.map((d) => d.difference(dates.first).inDays / totalDays).toList();

    double npv(double r) {
      double sum = 0;
      for (int i = 0; i < cashFlows.length; i++) {
        sum += cashFlows[i] / pow(1 + r, t[i]);
      }
      return sum;
    }

    double dnpv(double r) {
      double sum = 0;
      for (int i = 0; i < cashFlows.length; i++) {
        if (t[i] != 0) {
          sum -= t[i] * cashFlows[i] / pow(1 + r, t[i] + 1);
        }
      }
      return sum;
    }

    double r = 0.1;
    for (int i = 0; i < 100; i++) {
      final f = npv(r);
      final df = dnpv(r);
      if (df.abs() < 1e-10) break;
      final next = r - f / df;
      if ((next - r).abs() < 1e-7) return next;
      r = next.clamp(-0.999, 100.0);
    }
    return r;
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

    final withdrawAmount = _computeWithdrawAmount(
      session,
      quantity: investment.quantity,
      assetValue: asset.price!,
      currencyChangeRate: forex?.rate ?? 1,
      withdrawalRule: investment.withdrawalRule,
    );

    double? returnPercentage;
    double? realizedProfit;
    double? unrealizedProfit;
    double? totalProfit;

    if (investment.id != null) {
      final transfers = await Transfer.db.find(
        session,
        where: (e) => e.investmentId.equals(investment.id!),
        orderBy: (e) => e.createdAt,
      );

      if (transfers.isNotEmpty) {
        // Rolling PAMP (Prix d'Achat Moyen Pondéré) in account currency
        double pamp = 0;
        double rollingQuantity = 0;
        double computedRealizedProfit = 0;

        for (final t in transfers) {
          if (t.quantity > 0) {
            // Buy: update PAMP
            pamp = (pamp * rollingQuantity + t.amount) / (rollingQuantity + t.quantity);
            rollingQuantity += t.quantity;
          } else {
            // Sell: realize profit against PAMP cost basis
            final quantitySold = -t.quantity;
            final amountReceived = -t.amount;
            computedRealizedProfit += amountReceived - (quantitySold * pamp);
            rollingQuantity += t.quantity;
          }
        }

        realizedProfit = computedRealizedProfit;
        // Unrealized: liquidation value (net of fees) minus PAMP cost of remaining shares
        unrealizedProfit = withdrawAmount - (rollingQuantity * pamp);
        totalProfit = realizedProfit + unrealizedProfit;

        // Annualized XIRR: buys/sells at exact dates + current liquidation value
        final now = DateTime.timestamp();
        final cashFlows = [...transfers.map((t) => -t.amount), withdrawAmount];
        final dates = [...transfers.map((t) => t.createdAt), now];
        final xirr = _computeXirr(cashFlows, dates);
        returnPercentage = (xirr ?? 0) * 100;
      }
    }

    investment = investment.copyWith(
      asset: asset,
      withdrawAmount: withdrawAmount,
      forex: forex,
      returnPercentage: returnPercentage,
      realizedProfit: realizedProfit,
      unrealizedProfit: unrealizedProfit,
      totalProfit: totalProfit,
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

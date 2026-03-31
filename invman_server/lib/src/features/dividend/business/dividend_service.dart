import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/features/dividend/dividend.dart';
import 'package:invman_server/src/features/transfer/transfer.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class DividendService {
  final DividendSource dividendSource;
  final TransferService transferService;

  DividendService(this.dividendSource, this.transferService);

  Future<List<TotalDividendYear>> total(Session session, int fromYear, int toYear) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    final Map<String, Map<int, double>> currencyYearTotals = {};

    for (final investment in investments) {
      if (investment.asset == null) continue;
      final currency = investment.asset!.currency?.code ?? 'Unknown';

      final dividends = await dividendSource.getAllDividends(session, investment: investment);
      if (dividends.isEmpty) continue;

      final transfers = await transferService.listAll(session, investment.id!);
      if (transfers.isEmpty) continue;

      final startDate = transfers.first.createdAt;

      final relevantDividends = dividends.where((d) {
        return !d.date.isBefore(startDate) && d.date.year >= fromYear && d.date.year <= toYear;
      });

      for (final dividend in relevantDividends) {
        final quantityAtDividend = transfers
            .where((t) => t.createdAt.isBefore(dividend.date))
            .fold(0.0, (sum, t) => sum + t.quantity);

        currencyYearTotals[currency] ??= {};
        currencyYearTotals[currency]![dividend.date.year] =
            (currencyYearTotals[currency]![dividend.date.year] ?? 0) + quantityAtDividend * dividend.amount;
      }
    }

    final result = <TotalDividendYear>[];
    for (final currencyEntry in currencyYearTotals.entries) {
      for (final yearEntry in currencyEntry.value.entries) {
        result.add(TotalDividendYear(year: yearEntry.key, total: yearEntry.value, currency: currencyEntry.key));
      }
    }
    return result..sort((a, b) {
      final c = a.currency.compareTo(b.currency);
      return c != 0 ? c : a.year.compareTo(b.year);
    });
  }

  Future<List<ComputedDividendValue>> list(
    Session session, {
    required int limit,
    required int page,
  }) async {
    final sessionUserId = (session.authenticated)!.authUserId;
    final now = DateTime.timestamp();

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    final List<ComputedDividendValue> allDividends = [];

    for (final investment in investments) {
      if (investment.asset == null) continue;

      final dividends = await dividendSource.getAllDividends(session, investment: investment);
      if (dividends.isEmpty) continue;

      final transfers = await transferService.listAll(session, investment.id!);
      if (transfers.isEmpty) continue;

      final startDate = transfers.first.createdAt;

      for (final dividend in dividends) {
        if (dividend.date.isAfter(now)) continue;
        if (dividend.date.isBefore(startDate)) continue;

        final quantityAtDividend = transfers
            .where((t) => t.createdAt.isBefore(dividend.date))
            .fold(0.0, (sum, t) => sum + t.quantity);

        allDividends.add(
          ComputedDividendValue(
            date: dividend.date,
            amountPerShare: dividend.amount,
            amount: quantityAtDividend * dividend.amount,
          ),
        );
      }
    }

    allDividends.sort((a, b) => b.date.compareTo(a.date));

    final offset = (page * limit) - limit;
    return allDividends.skip(offset).take(limit).toList();
  }

  Future<List<InvestmentDividend>> calendar(Session session) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    final List<InvestmentDividend> result = [];

    for (final investment in investments) {
      if (investment.asset == null) continue;

      final dividends = await dividendSource.getCurrentYearDividends(session, investment: investment);
      if (dividends.isEmpty) continue;

      final transfers = await transferService.listAll(session, investment.id!);
      if (transfers.isEmpty) continue;

      final List<ComputedDividendValue> computedDividends = [];

      for (final dividend in dividends) {
        final quantityAtDividend = transfers
            .where((t) => t.createdAt.isBefore(dividend.date))
            .fold(0.0, (sum, t) => sum + t.quantity);

        computedDividends.add(
          ComputedDividendValue(
            date: dividend.date,
            amountPerShare: dividend.amount,
            amount: quantityAtDividend * dividend.amount,
          ),
        );
      }

      result.add(InvestmentDividend(investment: investment, dividends: computedDividends));
    }

    return result;
  }
}

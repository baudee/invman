import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class InvestmentService {
  InvestmentService();

  Future<InvestmentList> list(Session session, {int limit = 10, int page = 1}) async {
    final sessionUser = await session.authenticated;

    final count =
        await Stock.db.count(session, where: (s) => s.transfers.any((t) => t.userId.equals(sessionUser!.userId)));

    final stocks = await Stock.db.find(
      session,
      limit: limit,
      offset: (page * limit) - limit,
      where: (s) => s.transfers.any((t) => t.userId.equals(sessionUser!.userId)),
      include: IncludeHelpers.stockInclude(),
    );

    final List<Investment> investments = [];
    for (final stock in stocks) {
      final transfers = stock.transfers ?? [];
      int investAmount = 0;
      double quantity = 0;
      for (final transfer in transfers) {
        if (transfer.amount > 0) {
          investAmount += transfer.amount;
          quantity += transfer.quantity;
        } else {
          investAmount -= transfer.amount;
          quantity -= transfer.quantity;
        }
      }
      final withdrawAmount = (quantity * stock.value).toInt();
      final investment = Investment(
        stock: stock,
        investAmount: investAmount,
        withdrawAmount: 0,
      );

      investments.add(investment);
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
}

import 'package:invman_server/src/generated/protocol.dart';

class IncludeHelpers {
  // Withdrawal
  static WithdrawalRuleInclude withdrawalInclude() {
    return WithdrawalRule.include(
      fees: WithdrawalFee.includeList(),
    );
  }

  static WithdrawalFeeInclude withdrawalFeeInclude() {
    return WithdrawalFee.include(
      rule: WithdrawalRule.include(),
    );
  }

  // Investment
  static InvestmentInclude investmentInclude() {
    return Investment.include(
      stock: stockInclude(),
      withdrawalRule: withdrawalInclude(),
    );
  }

  // Currency
  static CurrencyInclude currencyInclude() {
    return Currency.include(
      rates: CurrencyRate.includeList(
        orderBy: (e) => e.timestamp,
        orderDescending: true,
        limit: 1,
      ),
    );
  }

  // Stock
  static StockInclude stockInclude() {
    return Stock.include(
      currency: currencyInclude(),
      prices: StockPrice.includeList(
        orderBy: (e) => e.timestamp,
        orderDescending: true,
        limit: 1,
      ),
    );
  }

  // Account
  static AccountInclude accountInclude() {
    return Account.include(
      currency: currencyInclude(),
    );
  }
}

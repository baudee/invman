import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

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

  // Stock
  static StockInclude stockInclude({UuidValue? userId}) {
    return Stock.include(
      currency: Currency.include(),
      likes: userId != null
          ? StockLike.includeList(
              where: (t) => t.userId.equals(userId),
            )
          : null,
    );
  }

  // Account
  static AccountInclude accountInclude() {
    return Account.include(
      currency: Currency.include(),
    );
  }
}

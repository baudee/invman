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
      stock: Stock.include(),
      withdrawalRule: withdrawalInclude(),
    );
  }
}

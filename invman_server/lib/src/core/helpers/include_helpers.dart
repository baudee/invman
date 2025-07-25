import 'package:invman_server/src/generated/protocol.dart';

class IncludeHelpers {
  // Transfer
  static TransferInclude transferInclude() {
    return Transfer.include(
      investment: Investment.include(),
    );
  }

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
      transfers: Transfer.includeList(
        orderBy: (e) => e.createdAt,
        orderDescending: true,
      ),
      withdrawalRule: withdrawalInclude(),
    );
  }
}

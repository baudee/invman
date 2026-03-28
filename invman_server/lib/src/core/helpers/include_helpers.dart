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
      asset: assetInclude(),
      withdrawalRule: withdrawalInclude(),
    );
  }

  // Asset
  static AssetInclude assetInclude({UuidValue? userId}) {
    return Asset.include(
      currency: Currency.include(),
      likes: userId != null
          ? AssetLike.includeList(
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

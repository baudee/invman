import 'package:invman_client/invman_client.dart';

class InitialUtils {
  static Asset getAsset() {
    return Asset(symbol: '', name: '', type: AssetType.stock, currencyId: 0);
  }

  static Transfer getTransfer() {
    return Transfer(id: 0, quantity: 0, amount: 0, investmentId: 0);
  }

  // Withdrawal
  static WithdrawalRule getWithdrawalRule() {
    return WithdrawalRule(
      id: 0,
      userId: UuidValue.fromString(Namespace.nil.value),
      currencyChangePercentage: 0.0,
      name: '',
    );
  }

  static WithdrawalFee getWithdrawalFee({required int ruleId}) {
    return WithdrawalFee(id: 0, fixed: 0.0, percent: 0.0, minimum: 0.0, ruleId: ruleId);
  }

  // Investment
  static Investment getInvestment() {
    return Investment(
      id: 0,
      userId: UuidValue.fromString(Namespace.nil.value),
      name: '',
      investAmount: 0,
      assetId: UuidValue.fromString(Namespace.nil.value),
      withdrawAmount: 0,
    );
  }
}

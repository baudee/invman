import 'package:invman_client/invman_client.dart';

class InitialUtils {
  static Stock getStock() {
    return Stock(name: '', symbol: '', currency: '', quoteType: '', value: 0.0, updatedAt: DateTime.now());
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
      withdrawalRuleId: 0,
      stock: InitialUtils.getStock(),
      investAmount: 0,
      stockId: 0,
      withdrawAmount: 0,
    );
  }
}

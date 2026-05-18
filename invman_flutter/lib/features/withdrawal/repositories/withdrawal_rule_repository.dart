import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class WithdrawalRuleRepository {
  final Client client;
  final InvestmentRepository _investmentRepository;

  WithdrawalRuleRepository(this.client, this._investmentRepository);

  final _invalidation = signal(false);
  Signal<bool> get invalidation => _invalidation;

  void _notifyChange() => _invalidation.value = !_invalidation.value;

  Future<Either<String, List<WithdrawalRule>>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.withdrawalRule.list(limit: limit, page: page));
    });
  }

  Future<Either<String, WithdrawalRule>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.withdrawalRule.retrieve(id));
    });
  }

  Future<Either<String, WithdrawalRule>> save(WithdrawalRule withdrawal) async {
    final result = await safeCall(() async {
      return right(await client.withdrawalRule.save(withdrawal));
    });
    if (result.isRight()) _notifyChange();
    return result;
  }

  Future<Either<String, WithdrawalRule>> delete(int id) async {
    final result = await safeCall(() async {
      return right(await client.withdrawalRule.delete(id));
    });
    if (result.isRight()) _notifyChange();
    return result;
  }

  Future<Either<String, void>> applyToInvestments(int ruleId, List<int> investmentIds) async {
    final result = await safeCall(() async {
      await client.withdrawalRule.applyToInvestments(ruleId, investmentIds);
      return right(null);
    });
    if (result.isRight()) _investmentRepository.saveInvalidate();
    return result;
  }
}

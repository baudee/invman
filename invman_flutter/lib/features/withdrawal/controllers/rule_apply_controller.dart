import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/withdrawal/repositories/withdrawal_rule_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalRuleApplyController extends PaginationController<Investment> {
  final int ruleId;
  final InvestmentRepository _investmentRepository;
  final WithdrawalRuleRepository _ruleRepository;

  final Signal<Set<int>> selectedIds = signal(<int>{});
  final Signal<bool> isApplying = signal(false);

  WithdrawalRuleApplyController(
    @factoryParam this.ruleId,
    this._investmentRepository,
    this._ruleRepository,
  );

  @override
  Future<Either<String, List<Investment>>> fetchPage(int page, int limit) async {
    final result = await _investmentRepository.list(page: page, limit: limit);
    result.fold((_) {}, (items) {
      final preset = items.where((i) => i.withdrawalRuleId == ruleId && i.id != null).map((i) => i.id!).toSet();
      if (preset.isNotEmpty) {
        selectedIds.value = {...selectedIds.value, ...preset};
      }
    });
    return result;
  }

  bool isLocked(Investment investment) => investment.withdrawalRuleId == ruleId;

  void toggle(int investmentId) {
    final next = {...selectedIds.value};
    if (next.contains(investmentId)) {
      next.remove(investmentId);
    } else {
      next.add(investmentId);
    }
    selectedIds.value = next;
  }

  /// Returns (success, errorMessage). When success, errorMessage is null.
  Future<(bool, String?)> apply() async {
    final all = selectedIds.value;
    final items = state.value.value ?? const [];
    final lockedIds = items.where(isLocked).map((i) => i.id!).toSet();
    final toApply = all.difference(lockedIds).toList();

    if (toApply.isEmpty) return (true, null);

    isApplying.value = true;
    final result = await _ruleRepository.applyToInvestments(ruleId, toApply);
    isApplying.value = false;

    return result.fold((error) => (false, error), (_) => (true, null));
  }
}

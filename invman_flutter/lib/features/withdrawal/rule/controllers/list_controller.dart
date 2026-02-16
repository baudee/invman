import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/repositories/withdrawal_rule_repository.dart';

@injectable
class WithdrawalRuleListController
    extends PaginationController<WithdrawalRule> {
  final WithdrawalRuleRepository _repository;

  WithdrawalRuleListController(this._repository) : super() {
    _repository.invalidation.subscribe((_) => refresh());
  }

  @override
  Future<Either<String, List<WithdrawalRule>>> fetchPage(int page) {
    return _repository.list(page: page, limit: 10);
  }
}

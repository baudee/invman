import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/services/withdrawal_rule_service.dart';

@injectable
class WithdrawalRuleListController extends PaginationController<WithdrawalRule> {
  final WithdrawalRuleService _service;

  WithdrawalRuleListController(this._service);

  @override
  Future<Either<String, List<WithdrawalRule>>> getData(int page) {
    return _service.list(page: page, limit: 10);
  }
}

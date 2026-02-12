import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/services/withdrawal_rule_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalRuleDetailController extends DetailController<int, WithdrawalRule> {
  final WithdrawalRuleService _service;
  AsyncSignal<WithdrawalRule> state = AsyncSignal<WithdrawalRule>(AsyncState.loading());

  WithdrawalRuleDetailController(@factoryParam super.id, this._service);

  @override
  Future<Either<String, WithdrawalRule>> retrieve(int id) {
    return _service.retrieve(id);
  }

  Future<(bool, String?)> delete() => DeleteCommand(onExecute: () => _service.delete(id)).execute();
}

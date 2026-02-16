import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/repositories/withdrawal_fee_repository.dart';

@injectable
class WithdrawalFeeDetailController
    extends DetailController<int, WithdrawalFee> {
  final WithdrawalFeeRepository _service;

  WithdrawalFeeDetailController(@factoryParam super.id, this._service);

  @override
  Future<Either<String, WithdrawalFee>> retrieve(int id) {
    return _service.retrieve(id);
  }

  Future<(bool, String?)> delete() =>
      DeleteCommand(onExecute: () => _service.delete(id)).execute();
}

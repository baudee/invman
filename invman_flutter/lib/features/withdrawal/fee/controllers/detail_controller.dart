import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/withdrawal/services/withdrawal_fee_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class WithdrawalFeeDetailController extends FutureSignal<WithdrawalFee> {
  final int id;
  final WithdrawalFeeService _service;

  WithdrawalFeeDetailController(
    @factoryParam this.id,
    this._service,
  ) : super(() => _service.retrieve(id));
}

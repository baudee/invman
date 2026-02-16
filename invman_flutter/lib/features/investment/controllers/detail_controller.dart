import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentDetailController extends DetailController<int, Investment> {
  final InvestmentRepository _service;
  AsyncSignal<Investment> state = AsyncSignal<Investment>(AsyncState.loading());

  InvestmentDetailController(@factoryParam super.id, this._service);

  @override
  Future<Either<String, Investment>> retrieve(int id) {
    return _service.retrieve(id);
  }

  Future<(bool, String?)> delete() =>
      DeleteCommand(onExecute: () => _service.delete(id)).execute();
}

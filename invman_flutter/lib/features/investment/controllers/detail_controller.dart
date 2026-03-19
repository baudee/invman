import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';

@injectable
class InvestmentDetailController extends DetailController<int, Investment> {
  final InvestmentRepository _service;

  InvestmentDetailController(@factoryParam super.id, this._service) : super();

  @override
  Future<Either<String, Investment>> retrieve(int id) {
    return _service.retrieve(id);
  }

  Future<(bool, String?)> delete() => DeleteCommand(onExecute: () => _service.delete(id)).execute();
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/repositories/investment_repository.dart';

@injectable
class InvestmentDetailController extends DetailController<int, Investment> {
  final InvestmentRepository _repository;

  InvestmentDetailController(@factoryParam super.id, this._repository) : super(fireImmediately: false) {
    _repository.invalidation.subscribe((_) => reload());
  }

  @override
  Future<Either<String, Investment>> retrieve(int id) {
    return _repository.retrieve(id);
  }

  Future<(bool, String?)> delete() => DeleteCommand(onExecute: () => _repository.delete(id)).execute();
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/controllers/detail_controller.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/transfer/repositories/transfer_repository.dart';

@injectable
class TransferDetailController extends DetailController<int, Transfer> {
  final TransferRepository _service;

  TransferDetailController(@factoryParam super.id, this._service);

  @override
  Future<Either<String, Transfer>> retrieve(int id) {
    return _service.retrieve(id);
  }

  Future<(bool, String?)> delete() => DeleteCommand(onExecute: () => _service.delete(id)).execute();
}

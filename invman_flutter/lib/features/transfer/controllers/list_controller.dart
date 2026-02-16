import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/transfer/repositories/transfer_repository.dart';

@injectable
class TransferListController extends PaginationController<Transfer> {
  final int investmentId;
  final TransferRepository _service;

  TransferListController(@factoryParam this.investmentId, this._service);

  @override
  Future<Either<String, List<Transfer>>> fetchPage(int page) {
    return _service.list(investmentId, page: page, limit: 10);
  }
}

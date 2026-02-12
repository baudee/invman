import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/transfer/services/transfer_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class TransferDetailController extends FutureSignal<Transfer> {
  final int id;
  final TransferService _service;

  TransferDetailController(
    @factoryParam this.id,
    this._service,
  ) : super(() => _service.retrieve(id));
}

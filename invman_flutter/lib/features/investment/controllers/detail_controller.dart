import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class InvestmentDetailController extends FutureSignal<Investment> {
  final int id;
  final InvestmentService _service;

  InvestmentDetailController(
    @factoryParam this.id,
    this._service,
  ) : super(() => _service.retrieve(id));
}

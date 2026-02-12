import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class InvestmentListController extends FutureSignal<List<Investment>> {
  final InvestmentService _service;

  InvestmentListController(this._service) : super(() => _service.list());
}

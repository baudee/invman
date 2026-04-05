import 'package:invman_client/invman_client.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class ReturnsProvider {
  ReadonlySignal<AsyncState<List<InvestmentReturn>>> getReturnsFromInterval(InvestmentReturnInterval interval);
  void reloadReturns(InvestmentReturnInterval interval);
}

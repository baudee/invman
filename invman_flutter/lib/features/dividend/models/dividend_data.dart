import 'package:invman_client/invman_client.dart';

class DividendData {
  final List<InvestmentDividend> calendar;
  final List<TotalDividendYear> history;

  DividendData({
    required this.calendar,
    required this.history,
  });
}